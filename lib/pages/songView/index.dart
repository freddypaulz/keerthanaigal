import 'package:flutter/material.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';
import 'package:keerthanaigal/utilities/customPageViewScrollPhysics.dart';
import 'package:keerthanaigal/utilities/dynamicLink.dart';
import 'package:keerthanaigal/utilities/removeFocus.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';
import 'package:keerthanaigal/widgets/languageDropdownWidget.dart';
import 'package:keerthanaigal/widgets/songNumberSearchWidget.dart';
import 'package:social_share/social_share.dart';
import '../../layout/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/song_provider.dart';

class SongView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int songNumber = ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as int
        : 1;
    return Container(
      child: Song(songNumber: songNumber),
    );
  }
}

class Song extends ConsumerWidget {
  Song({required this.songNumber});
  final int songNumber;
  @override
  Widget build(BuildContext context, watch) {
    SongState songsProviderData = watch(SongsProvider);
    var songs = songsProviderData.songList.songs;
    var favoriteList = songsProviderData.favoriteList;
    var uiProviderData = watch(UiProvider);
    if (songNumber != 1) {
      context.read(SongsProvider).setSongId(songNumber);
    }
    return PageView.builder(
      controller: PageController(initialPage: songsProviderData.songViewId - 1),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              child: TextWidget(
                text: uiProviderData.language == 0
                    ? songs[index].tamil.title
                    : songs[index].tanglish.title,
                align: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: 'Song: ${songs[index].number}',
                  fontSize: 18,
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.share_rounded,
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () async {
                          Uri url = await DynamicLink()
                              .createDynamicLink(number: songs[index].number);
                          SocialShare.shareOptions(url.toString());
                        },
                      ),
                      IconButton(
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
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: SongText(
                      song: uiProviderData.language == 0
                          ? songs[index].tamil.content
                          : songs[index].tanglish.content),
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
    return Consumer(
      builder: (context, watch, child) {
        UiState uiProviderData = watch(UiProvider);
        return ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  for (String item in song[index])
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: TextWidget(
                        text: item,
                        align: TextAlign.center,
                        fontFamily: uiProviderData.language == 0
                            ? 'Arima'
                            : 'SourceSansPro',
                      ),
                    ),
                ],
              ),
            );
          },
          itemCount: song.length,
        );
      },
    );
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const KAppBar({Key? key, required this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RemoveFocus.removeFocus(context);
      },
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            width: 110,
            margin: EdgeInsets.only(top: 10, bottom: 8, right: 8),
            child: LanguageDropdownWidget(),
          ),
          Container(
            width: 100,
            margin: EdgeInsets.only(top: 10, bottom: 8, right: 8),
            child: SongNumberSearchWidget(),
          ),
        ],
        // centerTitle: true,
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
