import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';

class ThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    UiState uiProviderData = watch(UiProvider);
    return SingleChildScrollView(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: RadioListTile(
              title: TextWidget(
                text: 'Light 💡',
                fontSize: 18,
              ),
              value: 0,
              groupValue: uiProviderData.theme,
              onChanged: (int? value) {
                uiProviderData.changeTheme(value!);
              },
              dense: true,
            ),
          ),
          SizedBox(
            height: 40,
            child: RadioListTile(
              title: TextWidget(
                text: 'Dark 🔥',
                fontSize: 18,
              ),
              value: 1,
              groupValue: uiProviderData.theme,
              onChanged: (int? value) {
                uiProviderData.changeTheme(value!);
              },
              dense: true,
            ),
          ),
          SizedBox(
            height: 40,
            child: RadioListTile(
              title: TextWidget(
                text: 'System',
                fontSize: 18,
              ),
              value: 2,
              groupValue: uiProviderData.theme,
              onChanged: (int? value) {
                uiProviderData.changeTheme(value!);
              },
              dense: true,
            ),
          ),
        ],
      ),
    ));
  }
}
