import 'package:Noting/app/models/note.dart';
import 'package:Noting/app/screens/update/controller.dart';
import 'package:Noting/app/screens/update/widget.dart';
import 'package:Noting/app/widgets/noting_button/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({@required this.note}) : assert(note != null);

  final Note note;

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Scrollbar(
            thickness: 3.0,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      NotingButton(
                        child: Icon(Icons.chevron_left, color: Colors.white),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Row(
                        children: <Widget>[
                          NotingButton(
                            child: Icon(Icons.edit, color: Colors.white),
                            type: NotingButtonType.OUTLINE,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                      controller: UpdateScreenController(),
                                      note: widget.note)));
                            },
                          ),
                          SizedBox(width: 16),
                          NotingButton(
                              child: Icon(Icons.delete, color: Colors.white),
                              type: NotingButtonType.OUTLINE),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 41),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        border: BorderDirectional(
                            start: BorderSide(
                                color: Color(0xFF726A95), width: 1))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.note.headline,
                          style: GoogleFonts.mukta(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(widget.note.formatedDate,
                            style: GoogleFonts.mukta(
                                fontSize: 18, color: Color(0xFFDEDEDE)))
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(widget.note.content,
                      style:
                          GoogleFonts.mukta(fontSize: 17, color: Colors.white)),
                ],
              ),
            )),
      );
}
