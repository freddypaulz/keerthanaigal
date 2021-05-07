import 'package:flutter/material.dart';
import 'package:keerthanaigal/pages/favorites/index.dart';
import 'package:keerthanaigal/pages/search/index.dart';
import 'package:keerthanaigal/pages/settings/index.dart';
import 'package:keerthanaigal/widgets/TextWidget.dart';
import '../home/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const KAppBar({Key? key, required this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: 'Keerthanaigal',
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState!.maybePop();

        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(3),
            ],
          ),
        ),
        // appBar: KAppBar(
        //   height: 50,
        // ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.music_note_rounded), label: 'Songs'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: 'Settings'),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).textTheme.bodyText1?.color,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          HomePage(),
          SearchPage(),
          FavoritesPage(),
          SettingsPage(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}
