import 'package:Noting/app/models/note.dart';
import 'package:flutter/material.dart';

abstract class UpdateScreenControllerContract {
  TextEditingController get headlineTextEditingController;
  TextEditingController get contentTextEditingController;
  Note update(Note note);
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
  Note update(Note note) {
    return Note(
        id: note.id,
        headline: _headlineTextEditingController.text,
        content: _contentTextEditingController.text,
        date: note.date);
  }

  @override
  void dispose() {
    _headlineTextEditingController.dispose();
    _contentTextEditingController.dispose();
  }
}
