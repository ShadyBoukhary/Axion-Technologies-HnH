import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'home/home_view.dart';
import 'login/login_view.dart';
import 'register/register_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
        title: "Hotter'n Hell",
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          primarySwatch: Colors.red,
          fontFamily: 'Poppins',
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    BorderSide(color: Color.fromRGBO(230, 38, 39, 0.8))),
            fillColor: Color.fromRGBO(255, 255, 255, 0.4),
            filled: true,
            hintStyle:
                TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          ),
        ),
        home: LoginPage(title: "Hotter'n Hell"),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new LoginPage(),
          '/register': (BuildContext context) => new RegisterPage(),
        });
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${e != null ? e?.message : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
