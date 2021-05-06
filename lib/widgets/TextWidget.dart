import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ui_provider.dart';

class TextWidget extends ConsumerWidget {
  const TextWidget({required this.text, this.fontSize});
  final String text;
  final double? fontSize;
  @override
  Widget build(BuildContext context, watch) {
    UiState uiProviderData = watch(UiProvider);
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1?.color,
        fontSize: fontSize != null ? fontSize : uiProviderData.fontSize,
        fontFamily: uiProviderData.language == 0 ? 'Arima' : 'SourceSansPro',
      ),
      textAlign: TextAlign.center,
    );
  }
}
