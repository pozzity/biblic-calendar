import 'package:biblic_calendar/services/bible_api_service.dart';
import 'package:biblic_calendar/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = Get.find<BibleApiService>();
    return Obx(() {
      final favs = api.favoriteVerses;
      if (favs.isEmpty) {
        return Center(
          child: Text('No favorites yet.', style: Styles.i.tsHeader1),
        );
      }
      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: favs.length,
        itemBuilder: (context, idx) {
          final fav = favs[idx];
          return Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Text(fav['text'] ?? '', style: Styles.i.tsBody1),
              subtitle: Text(
                'Book: ${fav['bookId']} | Chapter: ${fav['chapter']} | Verse: ${fav['verse']}',
                style: Styles.i.tsBody,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await api.removeFavorite(
                    fav['versionId'],
                    fav['bookId'],
                    fav['chapter'],
                    fav['verse'],
                  );
                },
              ),
            ),
          );
        },
      );
    });
  }
}
