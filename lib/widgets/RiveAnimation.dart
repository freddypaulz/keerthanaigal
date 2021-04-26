import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveAnimation extends StatefulWidget {
  RiveAnimation({
    required this.riveFileName,
    required this.animationName,
    this.secondAnimationName,
  });

  final String riveFileName;
  final String animationName;
  final String? secondAnimationName;

  @override
  _RiveAnimationState createState() => _RiveAnimationState(
        animationName: animationName,
        riveFileName: riveFileName,
        secondAnimationName: secondAnimationName,
      );
}

class _RiveAnimationState extends State<RiveAnimation> {
  _RiveAnimationState({
    required this.riveFileName,
    required this.animationName,
    this.secondAnimationName,
  });

  String riveFileName;
  String animationName;
  String? secondAnimationName;

  Artboard? _artboard;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile.import(bytes);
    if (this.mounted) {
      // check whether the state object is in tree
      setState(
        () => _artboard = file.mainArtboard
          ..addController(
            SimpleAnimation(animationName),
          ),
      );

      if (secondAnimationName != null) {
        _artboard?.addController(
          _controller = SimpleAnimation(secondAnimationName!),
        );
        setState(() => _controller?.isActive = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _artboard?.forEachComponent((child) {
      if (child is Shape && animationName == 'Book flip') {
        final Shape shape = child;
        shape.fills.first.paint.color = Theme.of(context).accentColor;
      }
    });
    return _artboard != null
        ? Rive(
            artboard: _artboard!,
            fit: BoxFit.fill,
            useArtboardSize: false,
          )
        : Container();
  }
}
