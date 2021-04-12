import 'package:flutter/material.dart';

import '../theme/colors.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    this.appBar,
    this.body,
    this.fab,
    this.bottomBar,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? fab;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: appBar,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: body,
      ),
      floatingActionButton: fab,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomBar,
    );
  }
}
