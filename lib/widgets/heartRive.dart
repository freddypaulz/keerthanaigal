import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveAnimation extends StatefulWidget {
  RiveAnimation({required this.riveFileName, required this.animationName});
  final String riveFileName;
  final String animationName;

  @override
  _RiveAnimationState createState() => _RiveAnimationState(
        animationName: animationName,
        riveFileName: riveFileName,
      );
}

class _RiveAnimationState extends State<RiveAnimation> {
  _RiveAnimationState(
      {required this.riveFileName, required this.animationName});

  String riveFileName;
  String animationName;

  Artboard? _artboard;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile.import(bytes);
    setState(() => _artboard = file.mainArtboard
      ..addController(
        SimpleAnimation(animationName),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return _artboard != null
        ? Rive(
            artboard: _artboard!,
            fit: BoxFit.fill,
            useArtboardSize: false,
          )
        : Container();
  }
}
