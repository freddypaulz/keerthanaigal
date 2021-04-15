import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keerthanaigal/layout/index.dart';
import 'package:keerthanaigal/pages/songView/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/theme/colors.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';
import '../../providers/song_provider.dart';
import '../../providers/ui_provider.dart';
import '../songView/index.dart';

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

class SongNumberSearchField extends ConsumerWidget {
  const SongNumberSearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final _controller = TextEditingController();
    SongState songsProviderData = watch(SongsProvider);

    handleSongNoSearch(String value) {
      int songIndex = songsProviderData.songList.songs
          .indexWhere((element) => element.number == int.parse(value));
      if (songIndex != -1) {
        songsProviderData.setSongId(int.parse(value));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SongViewPage()),
        );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                content: SingleChildScrollView(
                  child: TextWidget('No song found for that number!'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Got it!',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }

      print(value);
      _controller.clear();
    }

    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1?.color,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(5.0),
        hintText: 'Song No',
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.white70
                : KThemeData.colorDark.shade400,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      onSubmitted: handleSongNoSearch,
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
            child: SongNumberSearchField(),
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
