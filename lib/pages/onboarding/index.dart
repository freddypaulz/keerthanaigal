import 'package:flutter/material.dart';
import 'package:keerthanaigal/layout/index.dart';
import 'package:keerthanaigal/routes.dart';
import '../../utilities/firstTimeVisitChecker.dart';

class OnBoarding extends StatelessWidget {
  final FirstTimeVisitChecker visit = FirstTimeVisitChecker();

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Container(
        child: Column(
          children: [
            Text('Onboarding'),
            ElevatedButton(
              onPressed: () {
                visit.changeFirstTime();
                Navigator.pushNamed(context, Routes.homePage);
              },
              child: Text('Done'),
            )
          ],
        ),
      ),
    );
  }
}
