import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';

class ThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    UiState uiProviderData = watch(UiProvider);
    return Container(
        height: MediaQuery.of(context).size.height * .30,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                child: Text(
                  'Theme',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
              ),
              RadioListTile(
                title: Text(
                  'Light 💡',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
                value: 0,
                groupValue: uiProviderData.theme,
                onChanged: (int? value) {
                  uiProviderData.changeTheme(value!);
                },
              ),
              RadioListTile(
                title: Text(
                  'Dark 🔥',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
                value: 1,
                groupValue: uiProviderData.theme,
                onChanged: (int? value) {
                  uiProviderData.changeTheme(value!);
                },
              ),
              RadioListTile(
                title: Text(
                  'System',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
                value: 2,
                groupValue: uiProviderData.theme,
                onChanged: (int? value) {
                  uiProviderData.changeTheme(value!);
                },
              ),
            ],
          ),
        ));
  }
}
