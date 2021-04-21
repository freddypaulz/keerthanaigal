import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/layout/index.dart';
import 'package:keerthanaigal/pages/songView/index.dart';
import 'package:keerthanaigal/providers/song_provider.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';
import 'package:keerthanaigal/theme/colors.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchKey = '';
  Timer? _debounce;
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var uiProviderData = watch(UiProvider);
        var songProviderData = watch(SongsProvider);
        return Container(
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                searchKey = value;
              });
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                songProviderData.getSongSearchResults(searchKey);
              });
            },
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              hintText: 'Song title, lyrics, number',
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText2?.color,
                fontWeight: FontWeight.normal,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).accentColor,
              ),
              fillColor: uiProviderData.theme == 0
                  ? KThemeData.colorDark.shade50
                  : uiProviderData.theme == 1
                      ? KThemeData.colorLight.shade50
                      : MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? KThemeData.colorLight.shade50
                          : KThemeData.colorDark.shade50,
              filled: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

class SearchResults extends ConsumerWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    int count = context.read(SongsProvider).songSearchList.length;
    SongState songsProviderData = watch(SongsProvider);
    UiState uiProviderData = watch(UiProvider);

    return count != 0
        ? Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                int id = songsProviderData.songSearchList[index].id;
                String title = uiProviderData.language == 0
                    ? songsProviderData.songSearchList[index].tamil.title
                    : songsProviderData.songSearchList[index].tanglish.title;

                return InkWell(
                  onTap: () {
                    songsProviderData.setSongId(id);
                    Navigator.push(
                        context,
                        // Routes.songViewPage,
                        MaterialPageRoute(
                            builder: (context) => SongViewPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      '${index + 1}. $title',
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
            ),
          )
        : Text(
            songsProviderData.searchResultText,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontSize: 20,
            ),
          );
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SearchBar(),
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
        'Search',
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

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        children: [
          Search(),
          SizedBox(
            height: 40,
          ),
          SearchResults(),
        ],
      ),
      appBar: KAppBar(
        height: 50,
      ),
    );
  }
}
