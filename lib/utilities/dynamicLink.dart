import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:keerthanaigal/app.dart';

class DynamicLink {
  Future handleDynamicLink() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      int? number = int.parse(deepLink.queryParameters['number']!);
      if (number != null) {
        print('_handleDeepLink | deeplink: $deepLink | number: $number');

        navigatorKey.currentState?.pushNamed('/songView', arguments: number);
      }
    }
  }

  Future<Uri> createDynamicLink({required int number}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://keerthanaigal.page.link',
      link: Uri.parse('https://www.keerthanaigal.com/song?number=$number'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.keerthanaigal',
        minimumVersion: 1,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Keerthanaigal App',
        description:
            'Check out this awesome song lyrics your friend just shared',
        imageUrl: Uri.parse('https://i.ibb.co/yQTgchH/Logo-small.jpg'),
      ),
    );
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable,
      ),
    );
    return shortenedLink.shortUrl;
  }
}
