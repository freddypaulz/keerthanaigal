import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/models/song_model.dart';
import 'package:keerthanaigal/widgets/RiveAnimation.dart';
import '../../providers/song_provider.dart';
import '../../providers/ui_provider.dart';
import '../songView/index.dart';
import 'package:keerthanaigal/layout/index.dart';
import 'package:keerthanaigal/widgets/languageDropdownWidget.dart';
import 'package:keerthanaigal/widgets/songNumberSearchWidget.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SongListView(),
      ),
    );
  }
}

class SongListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    double width = MediaQuery.of(context).size.width;

    SongState songsProviderData = watch(SongsProvider);
    List<SongModel> songs = songsProviderData.songList.songs;
    List<String> favoriteList = songsProviderData.favoriteList;

    List<SongModel> favoriteSongs = songs.where((element) {
      return favoriteList.contains(element.number.toString());
    }).toList();

    int count = favoriteSongs.length;

    UiState uiProviderData = watch(UiProvider);

    uiProviderData.getFontSize(width);

    return count > 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              int id = favoriteSongs[index].id;
              String title = uiProviderData.language == 0
                  ? songsProviderData.songList.songs[index].tamil.title
                  : songsProviderData.songList.songs[index].tanglish.title;

              return InkWell(
                onTap: () {
                  songsProviderData.setSongId(id);
                  Navigator.push(
                      context,
                      // Routes.songViewPage,
                      MaterialPageRoute(builder: (context) => SongViewPage()));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  margin: EdgeInsets.all(5),
                  child: Text(
                    '${index + 1}. $title',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: uiProviderData.fontSize,
                      fontFamily: uiProviderData.language == 0
                          ? 'Arima'
                          : 'SourceSansPro',
                    ),
                  ),
                ),
              );
            },
            itemCount: count,
            physics: BouncingScrollPhysics(),
          )
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'oops! no favorites yet',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: RiveAnimation(
                    animationName: 'Heart broken',
                    riveFileName: 'assets/flare/heart_broken.riv',
                  ),
                )
              ],
            ),
          );
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const KAppBar({Key? key, required this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Favorites',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
      actions: [
        Container(
          width: 100,
          margin: EdgeInsets.only(top: 10, bottom: 8, right: 8),
          child: LanguageDropdownWidget(),
        ),
        Container(
          width: 110,
          margin: EdgeInsets.only(top: 10, bottom: 8, right: 8),
          child: SongNumberSearchWidget(),
        ),
      ],
      // centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Favorites(),
      appBar: KAppBar(
        height: 50,
      ),
    );
  }
}
