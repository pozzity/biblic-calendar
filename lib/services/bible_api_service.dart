import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/bible_models.dart';
import '../models/bible_version.dart';
import '../models/bible_book.dart';
import '../models/bible_content.dart';
import 'package:path/path.dart' as p;
import '../utils/functions.dart';

class BibleApiService extends GetxService {
  static const _baseUrl = 'https://bible.helloao.org/api';
  static const _translationsUrl =
      'https://bible.helloao.org/api/available_translations.json';

  final downloadedVersions = <BibleVersion>[].obs;
  final defaultVersionId = RxnString();
  final favoriteVerses = <Map<String, dynamic>>[].obs;
  List<BibleVersion> _allTranslations = [];

  List<BibleVersion> get allTranslations => _allTranslations;

  Future<Directory> _appDir() async {
    if (isTestMode) {
      final dir = Directory(
        p.join(Directory.systemTemp.path, 'biblic_calendar_test'),
      );
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return dir;
    }
    return await getApplicationDocumentsDirectory();
  }

  // Save downloaded versions and default version locally
  Future<void> saveDownloadedVersions() async {
    final dir = await _appDir();
    final file = File('${dir.path}/downloaded_versions.json');
    await file.writeAsString(
      jsonEncode(downloadedVersions.map((v) => v.toJson()).toList()),
    );
  }

  Future<void> loadDownloadedVersions() async {
    final dir = await _appDir();
    final file = File('${dir.path}/downloaded_versions.json');
    if (await file.exists()) {
      final data = jsonDecode(await file.readAsString());
      downloadedVersions.assignAll(
        (data as List).map((e) => BibleVersion.fromJson(e)).toList(),
      );
      // Ensure isDownloaded is true for all loaded versions
      for (var i = 0; i < downloadedVersions.length; i++) {
        downloadedVersions[i] = downloadedVersions[i].copyWith(
          isDownloaded: true,
        );
      }
      final def = downloadedVersions.firstWhereOrNull((v) => v.isDefault);
      if (def != null) defaultVersionId.value = def.id;
    }
  }

  // Fetch all available translations once and cache them
  Future<void> loadAllTranslations() async {
    if (isTestMode) {
      _allTranslations = [];
      return;
    }
    try {
      final res = await http.get(Uri.parse(_translationsUrl));
      if (res.statusCode == 200) {
        final allVersions = jsonDecode(res.body);
        // Build and cache the initial (empty query) results
        if (allVersions['translations'] is List) {
          List<BibleVersion> results = (allVersions['translations'] as List)
              .map<BibleVersion>((e) => BibleVersion.fromJson(e))
              .toList();
          final defaultId = defaultVersionId.value;
          if (defaultId != null) {
            final idx = results.indexWhere((v) => v.id == defaultId);
            if (idx > 0) {
              final def = results.removeAt(idx);
              results.insert(0, def);
            }
          }
          _allTranslations = results;
        } else {
          debugPrint('Unexpected JSON structure: $allVersions');
        }
      } else {
        debugPrint('API error: ${res.statusCode} for $_translationsUrl');
        debugPrint('Response: ${res.body}');
      }
    } catch (e) {
      debugPrint('Error loading translations: $e');
    }
  }

  // Fetch books for a translation (from API or local)
  Future<List<BibleBook>> fetchBooks(
    String translationId, {
    bool save = true,
  }) async {
    final dir = await _appDir();
    final booksFile = File('${dir.path}/bibles/$translationId/books.json');
    if (await booksFile.exists()) {
      final data = jsonDecode(await booksFile.readAsString());
      return (data as List).map((e) => BibleBook.fromJson(e)).toList();
    }
    if (isTestMode) return [];
    final res = await http.get(
      Uri.parse('$_baseUrl/$translationId/books.json'),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      List<BibleBook> books = [];
      if (data['books'] is List) {
        books = (data['books'] as List)
            .map((e) => BibleBook.fromJson(e))
            .toList();
      }
      if (save) {
        await booksFile.create(recursive: true);
        await booksFile.writeAsString(
          jsonEncode(books.map((b) => b.toJson()).toList()),
        );
      }
      return books;
    }
    return [];
  }

  // Fetch a chapter for a translation/book/chapter, prefer local storage
  Future<BibleChapter> fetchChapter(
    String translationId,
    String bookId,
    int chapter, {
    bool save = true,
  }) async {
    final dir = await _appDir();
    final chapterFile = File(
      '${dir.path}/bibles/$translationId/$bookId/$chapter.json',
    );
    if (await chapterFile.exists()) {
      final data = jsonDecode(await chapterFile.readAsString());
      return BibleChapter.fromJson(data);
    }
    if (isTestMode) {
      return BibleChapter(number: chapter, content: [], footnotes: []);
    }
    final res = await http.get(
      Uri.parse('$_baseUrl/$translationId/$bookId/$chapter.json'),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final chapterObj = BibleChapter.fromJson(data);
      if (save) {
        await chapterFile.create(recursive: true);
        await chapterFile.writeAsString(jsonEncode(chapterObj.toJson()));
      }
      return chapterObj;
    }
    return BibleChapter(number: chapter, content: [], footnotes: []);
  }

  // Fetch chapter content (returns all content, not just verses)
  Future<List<BibleContent>> fetchChapterContent(
    String translationId,
    String bookId,
    int chapter,
  ) async {
    final chapterObj = await fetchChapter(translationId, bookId, chapter);
    return chapterObj.content;
  }

  // Download a version: fetch and save all books and chapters locally
  Future<void> downloadVersion(BibleVersion version) async {
    final dir = await _appDir();
    final versionDir = Directory('${dir.path}/bibles/${version.id}');
    if (!await versionDir.exists()) {
      await versionDir.create(recursive: true);
    }
    // Fetch and save books
    final books = await fetchBooks(version.id, save: false);
    final booksFile = File('${versionDir.path}/books.json');
    await booksFile.writeAsString(
      jsonEncode(books.map((b) => b.toJson()).toList()),
    );

    // Use correct property for chapters count (numberOfChapters)
    for (final book in books) {
      final chaptersCount = book.numberOfChapters;
      for (int chapter = 1; chapter <= chaptersCount; chapter++) {
        final chapterData = await fetchChapter(
          version.id,
          book.id,
          chapter,
          save: false,
        );
        final chapterFile = File('${versionDir.path}/${book.id}_$chapter.json');
        await chapterFile.writeAsString(jsonEncode(chapterData.toJson()));
      }
    }
    // Mark as downloaded (avoid duplicates)
    if (!downloadedVersions.any((v) => v.id == version.id)) {
      downloadedVersions.add(version.copyWith(isDownloaded: true));
    } else {
      final idx = downloadedVersions.indexWhere((v) => v.id == version.id);
      downloadedVersions[idx] = downloadedVersions[idx].copyWith(
        isDownloaded: true,
      );
    }
    await saveDownloadedVersions();
  }

  // Set default version
  Future<void> setDefaultVersion(String versionId) async {
    for (var i = 0; i < downloadedVersions.length; i++) {
      downloadedVersions[i] = downloadedVersions[i].copyWith(
        isDefault: downloadedVersions[i].id == versionId,
      );
    }
    defaultVersionId.value = versionId;
    await saveDownloadedVersions();
  }

  // Favorite management
  Future<void> addFavorite(
    String versionId,
    String bookId,
    int chapter,
    int verse,
    String text,
  ) async {
    favoriteVerses.add({
      'versionId': versionId,
      'bookId': bookId,
      'chapter': chapter,
      'verse': verse,
      'text': text,
    });
    await saveFavorites();
  }

  Future<void> removeFavorite(
    String versionId,
    String bookId,
    int chapter,
    int verse,
  ) async {
    favoriteVerses.removeWhere(
      (v) =>
          v['versionId'] == versionId &&
          v['bookId'] == bookId &&
          v['chapter'] == chapter &&
          v['verse'] == verse,
    );
    await saveFavorites();
  }

  Future<void> saveFavorites() async {
    final dir = await _appDir();
    final file = File('${dir.path}/favorites.json');
    await file.writeAsString(jsonEncode(favoriteVerses));
  }

  Future<void> loadFavorites() async {
    final dir = await _appDir();
    final file = File('${dir.path}/favorites.json');
    if (await file.exists()) {
      favoriteVerses.assignAll(jsonDecode(await file.readAsString()));
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadDownloadedVersions();
    loadFavorites();
    loadAllTranslations();
  }
}
