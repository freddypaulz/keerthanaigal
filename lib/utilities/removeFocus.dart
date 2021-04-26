import 'package:flutter/material.dart';

class RemoveFocus {
  const RemoveFocus._();
  static removeFocus(context) {
    FocusScope.of(context).unfocus();
    new TextEditingController().clear();
  }
}
