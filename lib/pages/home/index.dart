import 'package:flutter/material.dart';
import '../../layout/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/song_provider.dart';
import '../../providers/ui_provider.dart';
import '../../routes.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
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
    int count = context.read(SongsProvider).songList.songs.length;
    SongState songsProviderData = watch(SongsProvider);
    UiState uiProviderData = watch(UiProvider);

    uiProviderData.getFontSize(width);

    return ListView.builder(
      itemBuilder: (context, index) {
        int id = songsProviderData.songList.songs[index].id;
        String title = songsProviderData.songList.songs[index].tamil.title;

        return InkWell(
          onTap: () {
            songsProviderData.setSongId(id);
            Navigator.pushNamed(
              context,
              Routes.songViewPage,
              arguments: id,
            );
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
    );
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const KAppBar({Key? key, required this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: ,
      title: Text(
        'Geethangalum Keerthanaigalum',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
      centerTitle: true,
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
      bottomBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
