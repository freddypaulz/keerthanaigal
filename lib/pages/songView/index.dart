import 'package:flutter/material.dart';
import 'package:keerthanaigal/theme/colors.dart';
import 'package:keerthanaigal/utilities/customPageViewScrollPhysics.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';
import '../../layout/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/song_provider.dart';

class SongView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Song(),
    );
  }
}

class Song extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    SongState songsProviderData = watch(SongsProvider);
    var songs = songsProviderData.songList.songs;
    var favoriteList = songsProviderData.favoriteList;

    return PageView.builder(
      controller: PageController(initialPage: songsProviderData.songViewId - 1),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget('Song: ${songs[index].number}'),
                Card(
                  elevation: 0,
                  color: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: Icon(
                      !favoriteList.contains(songs[index].number.toString())
                          ? Icons.favorite_border_rounded
                          : Icons.favorite_rounded,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      favoriteList.contains(songs[index].number.toString())
                          ? songsProviderData
                              .removeFavorite(songs[index].number)
                          : songsProviderData
                              .setFavoriteList(songs[index].number);
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: SongText(song: songs[index].tamil.content),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: songs.length,
      physics: CustomPageViewScrollPhysics(),
    );
  }
}

class SongText extends StatelessWidget {
  const SongText({
    Key? key,
    required this.song,
  }) : super(key: key);

  final List<List<String>> song;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              for (String item in song[index])
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: TextWidget(item),
                ),
            ],
          ),
        );
      },
      itemCount: song.length,
    );
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const KAppBar({Key? key, required this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Geethangalum Keerthanaigalum',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class SongViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: SongView(),
      appBar: KAppBar(
        height: 50,
      ),
    );
  }
}
