import 'package:biblic_calendar/models/bible_version.dart';
import 'package:biblic_calendar/services/bible_api_service.dart';
import 'package:biblic_calendar/utils/styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BibleTranslatesView extends StatefulWidget {
  const BibleTranslatesView({super.key});

  @override
  State<BibleTranslatesView> createState() => _BibleTranslatesViewState();
}

class _BibleTranslatesViewState extends State<BibleTranslatesView> {
  final BibleApiService api = Get.put(BibleApiService());
  final TextEditingController _searchCtrl = TextEditingController();
  List<BibleVersion> _searchResults = [];
  bool _loading = false;
  String? _downloadingId; // Track which version is being downloaded

  @override
  void initState() {
    super.initState();
    // Ensure translations are loaded before searching
    _initAndSearch();
  }

  Future<void> _initAndSearch() async {
    setState(() => _loading = true);
    if (api.allTranslations.isEmpty) {
      await api.loadAllTranslations();
    }
    await _search('');
  }

  Future<void> _search(String query) async {
    setState(() => _loading = true);
    final allVersions = api.allTranslations;
    List<BibleVersion> results;
    if (allVersions.isNotEmpty) {
      if (query.trim().isEmpty) {
        results = allVersions;
      } else {
        final q = query.trim().toLowerCase();
        results = allVersions
            .where(
              (v) =>
                  v.name.toLowerCase().contains(q) ||
                  v.language.toLowerCase().contains(q) ||
                  v.shortName.toLowerCase().contains(q) ||
                  v.englishName.toLowerCase().contains(q) ||
                  v.languageName.toLowerCase().contains(q),
            )
            .toList();
      }
    } else {
      results = [];
    }
    // Move default version to the top if present
    final defaultId = api.defaultVersionId.value;
    if (defaultId != null) {
      final idx = results.indexWhere((v) => v.id == defaultId);
      if (idx > 0) {
        final def = results.removeAt(idx);
        results.insert(0, def);
      }
    }
    setState(() {
      _searchResults = results;
      _loading = false;
    });
  }

  Widget _buildVersionTile(BibleVersion version) {
    final isDownloaded = api.downloadedVersions.any((v) => v.id == version.id);
    final isDefault = api.defaultVersionId.value == version.id;
    final isDownloading = _downloadingId == version.id;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isDefault ? Colors.brown.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade200,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.menu_book, color: Colors.brown.shade400, size: 32),
        title: Text(version.name, style: Styles.i.tsHeader1),
        subtitle: Text('${version.languageName} (${version.shortName})'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isDownloaded)
              isDownloading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                      ),
                      icon: Icon(Icons.download, size: 18),
                      label: Text('Download', style: Styles.i.tsBody),
                      onPressed: () async {
                        setState(() => _downloadingId = version.id);
                        await api.downloadVersion(version);
                        // Wait for downloadedVersions to update via GetX
                        await Future.delayed(const Duration(milliseconds: 100));
                        setState(() {
                          _downloadingId = null;
                        });
                      },
                    ),
            if (isDownloaded)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDefault
                      ? Colors.amber
                      : Colors.brown.shade300,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
                icon: Icon(Icons.check, size: 18),
                label: Text(
                  isDefault ? 'Default' : 'Set as default',
                  style: Styles.i.tsBody,
                ),
                onPressed: isDefault
                    ? null
                    : () async {
                        await api.setDefaultVersion(version.id);
                        setState(() {});
                      },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final downloaded = api.downloadedVersions;
      final defaultId = api.defaultVersionId.value;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search Bible version...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.brown.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _search,
            ),
          ),
          if (_loading)
            Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: ListView(
                children: _searchResults.map(_buildVersionTile).toList(),
              ),
            ),
          if (downloaded.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Downloaded: ${downloaded.map((v) => v.name).join(', ')}',
                style: Styles.i.tsBody1,
              ),
            ),
          if (defaultId == null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Please select a default Bible version to continue.',
                style: Styles.i.tsHeader.withValues(color: Colors.red),
              ),
            ),
        ],
      );
    });
  }
}
