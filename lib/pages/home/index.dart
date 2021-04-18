import 'package:flutter/material.dart';
import 'package:keerthanaigal/layout/index.dart';
import 'package:keerthanaigal/pages/songView/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/widgets/languageDropdownWidget.dart';
import 'package:keerthanaigal/widgets/songNumberSearchWidget.dart';
import '../../providers/song_provider.dart';
import '../../providers/ui_provider.dart';
import '../songView/index.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SongListView(),
    );
  }
}

class SongListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    double width = MediaQuery.of(context).size.width;
    int count = context.read(SongsProvider).songList.songs.length;
    SongState songsProviderData = watch(SongsProvider);
    UiState uiProviderData = watch(UiProvider);

    uiProviderData.getFontSize(width);

    return ListView.builder(
      itemBuilder: (context, index) {
        int id = songsProviderData.songList.songs[index].id;
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
              '$id. $title',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: uiProviderData.fontSize,
              ),
            ),
          ),
        );
      },
      itemCount: count,
      physics: BouncingScrollPhysics(),
    );
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const KAppBar({Key? key, required this.height});

  removeFocus(context) {
    FocusScope.of(context).unfocus();
    new TextEditingController().clear();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        removeFocus(context);
      },
      child: AppBar(
        title: Text(
          'Keerthanaigal',
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
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Home(),
      appBar: KAppBar(
        height: 50,
      ),
    );
  }
}
