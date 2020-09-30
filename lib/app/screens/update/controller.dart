import 'package:flutter/material.dart';

abstract class UpdateScreenControllerContract {
  TextEditingController get headlineTextEditingController;
  TextEditingController get contentTextEditingController;
  void dispose();
}

class UpdateScreenController implements UpdateScreenControllerContract {
  final TextEditingController _headlineTextEditingController =
      new TextEditingController();
  final TextEditingController _contentTextEditingController =
      new TextEditingController();

  @override
  TextEditingController get headlineTextEditingController =>
      _headlineTextEditingController;
  @override
  TextEditingController get contentTextEditingController =>
      _contentTextEditingController;

  @override
  void dispose() {
    _headlineTextEditingController.dispose();
    _contentTextEditingController.dispose();
  }
}
