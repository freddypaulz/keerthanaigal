import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/layout/index.dart';
import 'package:keerthanaigal/pages/main/index.dart';
import 'package:keerthanaigal/pages/settings/widgets/fontSizeSlider.dart';
import 'package:keerthanaigal/pages/settings/widgets/themeToggle.dart';
import 'package:keerthanaigal/utilities/customPageViewScrollPhysics.dart';
import 'package:keerthanaigal/widgets/RiveAnimation.dart';
import 'package:keerthanaigal/widgets/languageDropdownWidget.dart';
import '../../utilities/firstTimeVisitChecker.dart';

class VerseScreen extends StatelessWidget {
  const VerseScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Text(
          'Welcome to the Keerthanaigal App',
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
          width: MediaQuery.of(context).size.width,
          child: Text(
            'By the immense Grace of our Holy Father, the Keerthanaigal app brings over 700 classic songs from the book of Geethangal and Keerthanaigal.',
            // 'Our mission is to bring these classic songs to the community in a modern way with all the new features that an app can provide. By the immense Grace of our Holy Father, the Keethanaigal app brings over 700 classic songs from the book of Geethangal and Keethanaigal.',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
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
        Text(
          'Choose song language',
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
          child: LanguageDropdownWidget(
            underline: true,
          ),
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
        Text(
          'Choose application theme',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          width: 280,
          child: ThemeToggle(),
        )
      ],
    );
  }
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final FirstTimeVisitChecker visit = FirstTimeVisitChecker();

  var _controller = new PageController(initialPage: 0);
  int _numPages = 5;
  int _currentPage = 0;
  double _opacity = 0;
  Widget? _actionButton;

  _handleShapeChange(String value) {
    setState(() {
      _actionButton = value == 'rectangle' ? rectangleButton() : roundButton();
    });
  }

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

  _handleNext() {
    if (_currentPage == _numPages - 1) {
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
  }

  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
        _actionButton = rectangleButton();
      });
    });
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
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: (MediaQuery.of(context).size.width / 4) * 3,
                  child: RiveAnimation(
                    riveFileName: 'assets/flare/book_open.riv',
                    animationName: 'Book open',
                    secondAnimationName: 'Cross hover',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
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
                          _currentPage != _numPages - 1
                              ? _handleShapeChange('rectangle')
                              : _handleShapeChange('circle');
                        },
                        controller: _controller,
                        physics: CustomPageViewScrollPhysics(),
                        children: [
                          AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(
                              milliseconds: 4000,
                            ),
                            child: VerseScreen(),
                          ),
                          AboutScreen(),
                          LanguageScreen(),
                          FontSizeScreen(),
                          ThemeScreen(),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
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
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _actionButton,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget rectangleButton() {
    return ElevatedButton(
      key: Key('1'),
      style: ElevatedButton.styleFrom(
          shape: ContinuousRectangleBorder(),
          primary: Theme.of(context).accentColor,
          onPrimary: Colors.white70,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
      onPressed: _handleNext,
      child: Text('Next'),
    );
  }

  Widget roundButton() {
    return ElevatedButton(
      key: Key('2'),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: Theme.of(context).accentColor,
        onPrimary: Colors.white70,
        padding: EdgeInsets.all(10),
      ),
      onPressed: _handleNext,
      child: Icon(
        Icons.keyboard_arrow_right_rounded,
        size: 30,
      ),
    );
  }
}
