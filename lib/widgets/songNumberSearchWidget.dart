import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/pages/songView/index.dart';
import 'package:keerthanaigal/providers/song_provider.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';
import 'package:keerthanaigal/theme/colors.dart';
import 'package:keerthanaigal/widgets/RiveAnimation.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';

class SongNumberSearchWidget extends ConsumerWidget {
  const SongNumberSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final _controller = TextEditingController();
    SongState songsProviderData = watch(SongsProvider);
    var uiProviderData = watch(UiProvider);

    handleSongNoSearch(String value) {
      if (value.isNotEmpty) {
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: 'oops! song not found',
                          fontSize: 18,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: RiveAnimation(
                            animationName: 'Monocle blink',
                            riveFileName: 'assets/flare/monocle_blink.riv',
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: TextWidget(
                        text: 'Got it!',
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
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
      cursorColor: Theme.of(context).textTheme.bodyText1?.color,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(5.0),
        hintText: 'Song No',
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
        fillColor: uiProviderData.theme == 0
            ? KThemeData.colorDark.shade50
            : uiProviderData.theme == 1
                ? KThemeData.colorLight.shade50
                : MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? KThemeData.colorLight.shade50
                    : KThemeData.colorDark.shade50,
        filled: true,
        enabledBorder: InputBorder.none,
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
