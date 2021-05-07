import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ui_provider.dart';

class TextWidget extends ConsumerWidget {
  const TextWidget({
    required this.text,
    this.fontSize,
    this.align,
    this.fontWeight,
    this.color,
    this.fontFamily,
  });
  final String text;
  final double? fontSize;
  final TextAlign? align;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  @override
  Widget build(BuildContext context, watch) {
    UiState uiProviderData = watch(UiProvider);
    return Text(
      text,
      style: TextStyle(
        color: color != null
            ? color
            : Theme.of(context).textTheme.bodyText1?.color,
        fontSize: fontSize != null ? fontSize : uiProviderData.fontSize,
        fontFamily: fontFamily != null ? fontFamily : 'SourceSansPro',
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
      ),
      textAlign: align != null ? align : TextAlign.start,
    );
  }
}
