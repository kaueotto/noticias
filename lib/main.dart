import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noticias/MyWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noticias/authCheck.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Produtos",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.bebasNeueTextTheme(),
          scaffoldBackgroundColor: Colors.blue[100]),

      //darkTheme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("Produtos",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          body: Center(
            child: AuthCheck(),
          )),
    );
  }
}
