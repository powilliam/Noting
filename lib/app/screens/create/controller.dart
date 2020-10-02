import 'package:Noting/app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class CreateScreenControllerContract {
  GlobalKey<ScaffoldState> get scaffoldKey;
  TextEditingController get headlineTextEditingController;
  TextEditingController get contentTextEditingController;
  bool validate();
  Note create();
  void dispose();
}

class CreateScreenController implements CreateScreenControllerContract {
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
