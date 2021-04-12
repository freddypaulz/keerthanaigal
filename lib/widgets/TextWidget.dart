import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ui_provider.dart';

class TextWidget extends ConsumerWidget {
  const TextWidget(this.text);
  final String text;
  @override
  Widget build(BuildContext context, watch) {
    UiState uiProviderData = watch(UiProvider);
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1?.color,
        fontSize: uiProviderData.fontSize,
      ),
    );
  }
}
