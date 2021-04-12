import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeVisitChecker {
  Future<bool> firstTimeVisitChecker() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getBool('firstTimeVisit'));
    bool firstTimeVisit = pref.getBool('firstTimeVisit') == null ? true : false;

    return firstTimeVisit;
  }

  changeFirstTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('firstTimeVisit', false);
  }
}
