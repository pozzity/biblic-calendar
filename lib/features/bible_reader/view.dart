// Export main view and widgets for bible_reader feature here as needed.
import 'package:biblic_calendar/models/bible_book.dart';
import 'package:biblic_calendar/models/bible_content.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';
import 'package:biblic_calendar/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BibleReaderView extends StatefulWidget {
  const BibleReaderView({super.key});

  @override
  State<BibleReaderView> createState() => _BibleReaderViewState();
}

class _BibleReaderViewState extends State<BibleReaderView>
    with TickerProviderStateMixin {
  final BibleApiService api = Get.find<BibleApiService>();
  List<BibleBook> _books = [];
  bool _loading = true;
  String? _selectedBookId;
  int? _selectedChapter;
  List<BibleContent> _content = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    setState(() => _loading = true);
    final versionId = api.downloadedVersions
        .firstWhereOrNull((v) => v.isDefault)
        ?.id;
    if (versionId != null) {
      _books = await api.fetchBooks(versionId);
    } else {
      _books = [];
    }
    setState(() => _loading = false);
  }

  Future<void> _loadChapter(String bookId, int chapter) async {
    setState(() {
      _loading = true;
      _selectedBookId = bookId;
      _selectedChapter = chapter;
      _content = [];
    });
    final versionId = api.downloadedVersions
        .firstWhereOrNull((v) => v.isDefault)
        ?.id;
    print("Version ID: ${versionId}");
    if (versionId != null) {
      final content = await api.fetchChapterContent(versionId, bookId, chapter);
      setState(() {
        _content = content;
        _loading = false;
      });
    } else {
      setState(() {
        _content = [];
        _loading = false;
      });
    }
  }

  Widget _buildBooksGrid() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: GridView.builder(
        key: ValueKey(_books.length),
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 24,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _books.length,
        itemBuilder: (context, idx) {
          final book = _books[idx];
          return GestureDetector(
            onTap: () => _showChaptersDialog(book),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.shade200,
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  book.name,
                  textAlign: TextAlign.center,
                  style: Styles.i.tsHeader1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showChaptersDialog(BibleBook book) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.brown.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Wrap(
            children: [
              Center(child: Text(book.name, style: Styles.i.tsHeader2)),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(book.numberOfChapters, (i) {
                  final chap = i + 1;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade200,
                      shape: StadiumBorder(),
                      elevation: 6,
                    ),
                    child: Text('Ch. $chap', style: Styles.i.tsBody1),
                    onPressed: () async {
                      Navigator.pop(context);
                      await _loadChapter(book.id, chap);
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentList() {
    final versionId = api.downloadedVersions
        .firstWhereOrNull((v) => v.isDefault)
        ?.id;
    final bookId = _selectedBookId!;
    final chapter = _selectedChapter!;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: ListView.builder(
        key: ValueKey(_content.length),
        padding: EdgeInsets.all(16),
        itemCount: _content.length,
        itemBuilder: (context, idx) {
          final item = _content[idx];
          print('Item: $item');
          if (item.type == "heading") {
            final headingText =
                (item.content != null && item.content!.isNotEmpty)
                ? item.content!.whereType<String>().join(" ")
                : '';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: Text(
                  headingText,
                  style: Styles.i.tsHeader2.withValues(
                    color: Colors.brown.shade900,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (item.type == "line_break") {
            return const SizedBox(height: 24);
          } else if (item.type == "verse") {
            final verseNum = item.number ?? 0;
            final text = (item.content != null && item.content!.isNotEmpty)
                ? item.content!.whereType<String>().join(" ")
                : '';
            final isFav =
                versionId != null &&
                api.favoriteVerses.any(
                  (v) =>
                      v['versionId'] == versionId &&
                      v['bookId'] == bookId &&
                      v['chapter'] == chapter &&
                      v['verse'] == verseNum,
                );
            return Card(
              elevation: 8,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'verse $verseNum:',
                      style: Styles.i.tsBody1.withValues(
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Text(text, style: Styles.i.tsBody1)),
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: versionId == null
                              ? null
                              : () async {
                                  if (isFav) {
                                    await api.removeFavorite(
                                      versionId,
                                      bookId,
                                      chapter,
                                      verseNum,
                                    );
                                  } else {
                                    await api.addFavorite(
                                      versionId,
                                      bookId,
                                      chapter,
                                      verseNum,
                                      text,
                                    );
                                  }
                                  setState(() {});
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Center(child: CircularProgressIndicator());
    if (_selectedBookId != null && _selectedChapter != null) {
      // Show content only if loaded
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.brown),
                  onPressed: () {
                    setState(() {
                      _selectedBookId = null;
                      _selectedChapter = null;
                      _content = [];
                    });
                  },
                ),
                Text('Chapter $_selectedChapter', style: Styles.i.tsHeader1),
              ],
            ),
          ),
          Expanded(
            child: _content.isEmpty
                ? Center(
                    child: Text(
                      'No content found for this chapter.',
                      style: Styles.i.tsBody1,
                    ),
                  )
                : _buildContentList(),
          ),
        ],
      );
    }
    return _buildBooksGrid();
  }
}
