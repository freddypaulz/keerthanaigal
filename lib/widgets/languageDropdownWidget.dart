import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';

class LanguageDropdownWidget extends StatefulWidget {
  LanguageDropdownWidget({this.underline});
  final bool? underline;
  @override
  _LanguageDropdownWidgetState createState() =>
      _LanguageDropdownWidgetState(underline);
}

class _LanguageDropdownWidgetState extends State<LanguageDropdownWidget> {
  bool? underline;

  _LanguageDropdownWidgetState(this.underline);

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

        return DropdownButton(
          isExpanded: true,
          dropdownColor: Theme.of(context).primaryColor,
          iconEnabledColor: Theme.of(context).accentColor,
          focusColor: Theme.of(context).accentColor,
          hint: dropdownTextWidget('Language'),
          value: uiProviderData.language,
          onChanged: (int? value) {
            context.read(UiProvider).changeSongLanguage(value!);
          },
          underline: underline == null ? SizedBox() : null,
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
    return TextWidget(
      text: value,
      fontSize: 18,
    );
  }
}
