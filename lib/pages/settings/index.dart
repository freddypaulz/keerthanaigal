import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/pages/settings/widgets/fontSizeSlider.dart';
import 'package:keerthanaigal/pages/settings/widgets/themeToggle.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';
import '../../providers/ui_provider.dart';
import 'package:keerthanaigal/layout/index.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SettingsListView(),
      ),
    );
  }
}

class SettingsTextWidget extends StatelessWidget {
  const SettingsTextWidget({
    Key? key,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).accentColor,
        ),
        Container(
          padding: EdgeInsets.only(right: 5),
        ),
        TextWidget(
          text: value,
          fontSize: 20,
        ),
      ],
    );
  }
}

class SettingsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () {
            context
                .read(UiProvider)
                .changeTempFontSize(context.read(UiProvider).fontSize);
            _showFontDialog(context);
          },
          child: Container(
            child: SettingsTextWidget(
              value: 'Font Size',
              icon: Icons.font_download,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
        ),
        InkWell(
          child: Container(
            child: SettingsTextWidget(
              value: 'Language',
              icon: Icons.language_rounded,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
        ),
        InkWell(
          onTap: () {
            _showThemeDialog(context);
          },
          child: Container(
            child: SettingsTextWidget(
              value: 'Theme',
              icon: Icons.format_paint_rounded,
            ),
          ),
        ),
      ],
    );
  }

  _showFontDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          content: FontSizeSlider(),
          actions: <Widget>[
            TextButton(
              child: TextWidget(
                text: 'Default',
                color: Theme.of(context).accentColor,
                fontSize: 18,
              ),
              onPressed: () {
                context.read(UiProvider).changeTempFontSize(18);
              },
            ),
            TextButton(
              child: TextWidget(
                text: 'Set',
                color: Theme.of(context).accentColor,
                fontSize: 18,
              ),
              onPressed: () {
                double value = context.read(UiProvider).getTempFontSize();
                context.read(UiProvider).changeFontSize(value);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showThemeDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          content: ThemeToggle(),
          actions: <Widget>[
            TextButton(
              child: TextWidget(
                text: 'Close',
                color: Theme.of(context).accentColor,
                fontSize: 18,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const KAppBar({Key? key, required this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: 'Settings',
        fontSize: 18,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Settings(),
      appBar: KAppBar(
        height: 50,
      ),
    );
  }
}
