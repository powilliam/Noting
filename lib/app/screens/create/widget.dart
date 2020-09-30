import 'package:Noting/app/screens/create/controller.dart';
import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({@required this.controller}) : assert(controller != null);

  final CreateScreenControllerContract controller;

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Scrollbar(
        thickness: 3.0,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: insets.top + 21, left: 21, right: 21, bottom: 21),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  NotingButton(
                    child: Icon(Icons.close, color: Colors.white),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  NotingButton(
                      child: Icon(Icons.check, color: Colors.white),
                      type: NotingButtonType.OUTLINE),
                ],
              ),
              SizedBox(height: 41),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        start: BorderSide(color: Color(0xFF726A95), width: 1))),
                child: TextField(
                  controller: widget.controller.headlineTextEditingController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Headline',
                      hintStyle: GoogleFonts.mukta(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  style: GoogleFonts.mukta(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: null,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: widget.controller.contentTextEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write what you have in mind',
                    hintStyle: GoogleFonts.mukta(
                        fontSize: 17, color: Color(0xFFDEDEDE))),
                style:
                    GoogleFonts.mukta(fontSize: 17, color: Color(0xFFDEDEDE)),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
