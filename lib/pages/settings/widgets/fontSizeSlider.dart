import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';

class FontSizeSlider extends ConsumerWidget {
  // double _currentSliderValue = 0;
  // initState() {
  //   super.initState();
  //   _currentSliderValue = context.read(UiProvider).fontSize;
  // }

  @override
  Widget build(BuildContext context, watch) {
    UiState uiProviderData = watch(UiProvider);
    var _currentSliderValue = uiProviderData.tempFontSize;
    return SingleChildScrollView(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: Text(
              'Font Size',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: _currentSliderValue,
              ),
            ),
          ),
          Slider(
            value: _currentSliderValue,
            min: 18,
            max: 30,
            divisions: 4,
            // label: _currentSliderValue.round().toString(),
            activeColor: Theme.of(context).accentColor,
            inactiveColor: Theme.of(context).textTheme.bodyText1?.color,
            onChanged: (double value) {
              uiProviderData.changeTempFontSize(value);
            },
          ),
        ],
      ),
    ));
  }
}
