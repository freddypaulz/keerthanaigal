import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';

class LanguageDropdownWidget extends StatefulWidget {
  @override
  _LanguageDropdownWidgetState createState() => _LanguageDropdownWidgetState();
}

class _LanguageDropdownWidgetState extends State<LanguageDropdownWidget> {
  @override
  void initState() {
    super.initState();
    context.read(UiProvider).getUserSongLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        UiState uiProviderData = watch(UiProvider);
        print('${uiProviderData.language}, drop');

        return DropdownButton(
          dropdownColor: Theme.of(context).primaryColor,
          iconEnabledColor: Theme.of(context).accentColor,
          focusColor: Theme.of(context).accentColor,
          hint: dropdownTextWidget('Language'),
          value: uiProviderData.language,
          onChanged: (int? value) {
            print(value);
            context.read(UiProvider).changeSongLanguage(value!);
          },
          underline: SizedBox(),
          items: [
            DropdownMenuItem(
              child: dropdownTextWidget('Tamil'),
              value: 0,
            ),
            DropdownMenuItem(
              child: dropdownTextWidget('Tanglish'),
              value: 1,
            ),
          ],
        );
      },
    );
  }

  Widget dropdownTextWidget(String value) {
    return Text(
      value,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1?.color,
        fontSize: 18,
      ),
    );
  }
}
