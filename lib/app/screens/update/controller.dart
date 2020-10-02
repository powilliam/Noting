import 'package:Noting/app/models/note.dart';
import 'package:flutter/material.dart';

abstract class UpdateScreenControllerContract {
  GlobalKey<ScaffoldState> get scaffoldKey;
  TextEditingController get headlineTextEditingController;
  TextEditingController get contentTextEditingController;
  bool validate();
  Note update(Note note);
  void dispose();
}

class UpdateScreenController implements UpdateScreenControllerContract {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _headlineTextEditingController =
      new TextEditingController();
  final TextEditingController _contentTextEditingController =
      new TextEditingController();

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  @override
  TextEditingController get headlineTextEditingController =>
      _headlineTextEditingController;
  @override
  TextEditingController get contentTextEditingController =>
      _contentTextEditingController;

  @override
  bool validate() => _headlineTextEditingController.text.isNotEmpty;

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
