import 'package:Noting/app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class CreateScreenControllerContract {
  TextEditingController get headlineTextEditingController;
  TextEditingController get contentTextEditingController;
  Note create();
  void dispose();
}

class CreateScreenController implements CreateScreenControllerContract {
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
  Note create() {
    return Note(
        id: Uuid().v4(),
        headline: _headlineTextEditingController.text,
        content: _contentTextEditingController.text,
        date: DateTime.now());
  }

  @override
  void dispose() {
    _headlineTextEditingController.dispose();
    _contentTextEditingController.dispose();
  }
}
