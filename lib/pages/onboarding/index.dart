import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:keerthanaigal/layout/index.dart';
import 'package:keerthanaigal/pages/main/index.dart';
import 'package:keerthanaigal/pages/settings/widgets/fontSizeSlider.dart';
import 'package:keerthanaigal/pages/settings/widgets/themeToggle.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';
import 'package:keerthanaigal/routes.dart';
import 'package:keerthanaigal/utilities/customPageViewScrollPhysics.dart';
import 'package:keerthanaigal/widgets/languageDropdownWidget.dart';
import '../../utilities/firstTimeVisitChecker.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final FirstTimeVisitChecker visit = FirstTimeVisitChecker();

  var _controller = new PageController(initialPage: 0);
  int _numPages = 5;
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).textTheme.bodyText1?.color
            : Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Container(
              height: 600,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: PageView(
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    controller: _controller,
                    physics: CustomPageViewScrollPhysics(),
                    children: [
                      VerseScreen(),
                      AboutScreen(),
                      LanguageScreen(),
                      FontSizeScreen(),
                      ThemeScreen(),
                    ]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          Consumer(
            builder: (context, watch, child) {
              return Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Theme.of(context).primaryColor;
                          return Theme.of(context)
                              .accentColor; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, Routes.mainPage);
                      if (_currentPage == 3) {
                        double value =
                            context.read(UiProvider).getTempFontSize();
                        context.read(UiProvider).changeFontSize(value);
                      }
                      if (_currentPage == _numPages - 1) {
                        // Navigator.pushNamed(context, Routes.mainPage);
                        visit.changeFirstTime();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      }
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      _currentPage != _numPages - 1 ? 'Next' : 'Finish',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class VerseScreen extends StatelessWidget {
  const VerseScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          '"I will sing of the Lord’s great love forever; with my mouth I will make your faithfulness known through all generations."',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Psalm - 89:1',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'Welcome to the book of Keethanaigal',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 500,
          child: Text(
            'Our mission is to bring these classic songs to the community in a modern way with all the new features an app can provide. By the immense Grace of our Holy Father, the Keethanaigal app brings over 700 classic songs from the book of Geethangalum Keethanaigalum',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'Choose a song language',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 280,
          child: LanguageDropdownWidget(underline: true),
        )
      ],
    );
  }
}

class FontSizeScreen extends StatelessWidget {
  const FontSizeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'Choose song font size',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 280,
          child: FontSizeSlider(),
        )
      ],
    );
  }
}

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          'Choose application theme',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 280,
          child: ThemeToggle(),
        )
      ],
    );
  }
}
