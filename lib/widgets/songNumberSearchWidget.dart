import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/pages/songView/index.dart';
import 'package:keerthanaigal/providers/song_provider.dart';
import 'package:keerthanaigal/theme/colors.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';

class SongNumberSearchWidget extends ConsumerWidget {
  const SongNumberSearchWidget({Key? key}) : super(key: key);

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
            color: Theme.of(context).accentColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2.0,
          ),
        ),
      ),
      onSubmitted: handleSongNoSearch,
    );
  }
}
