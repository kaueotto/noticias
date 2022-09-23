import 'package:flutter/material.dart';
import 'package:noticias/MyWidget.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoticiasApp",
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: GoogleFonts.bebasNeueTextTheme(),
          scaffoldBackgroundColor: Colors.blueGrey[100]),

      //darkTheme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("Noticias",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          
          body: Center(
            child: NotWidget(),
          )),
    );
  }
}
