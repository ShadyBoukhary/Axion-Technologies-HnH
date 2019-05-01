import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hnh/app/pages/splash/splash_view.dart';
import 'package:hnh/app/utils/router.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:logging/logging.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Router _router;

  MyApp() : _router = Router() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black38));

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
              borderSide: BorderSide(color: Color.fromRGBO(230, 38, 39, 0.8))),
          fillColor: Color.fromRGBO(255, 255, 255, 0.4),
          filled: true,
          hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      String m = e is APIException ? e.message : e.toString();
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
