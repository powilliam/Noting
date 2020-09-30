import 'package:Noting/app/screens/create/controller.dart';
import 'package:Noting/app/screens/create/widget.dart';
import 'package:Noting/app/widgets/notes_grid_view/widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF121212),
        body: NotesGridView(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF212121),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateScreen(
                      controller: CreateScreenController(),
                    )));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
}
