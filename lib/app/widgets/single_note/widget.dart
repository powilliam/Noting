import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleNote extends StatelessWidget {
  SingleNote(
      {Key key,
      this.margin,
      this.color = const Color(0xFF212121),
      this.onTap,
      this.title,
      this.date})
      : assert(title != null),
        assert(date != null),
        super(key: key);

  final EdgeInsetsGeometry margin;
  final Color color;
  final VoidCallback onTap;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(14),
          margin: margin,
          constraints: BoxConstraints(minHeight: 176),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: GoogleFonts.mukta(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(date,
                  style: GoogleFonts.mukta(
                    color: Color(0xFFDEDEDE),
                    fontSize: 16,
                  ))
            ],
          ),
        ),
      );
}
