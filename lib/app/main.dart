import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home/home_view.dart';
import 'package:logging/logging.dart';
import 'login/login_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp() { initLogger(); }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          primarySwatch: Colors.red,
          fontFamily: 'Poppins',
        ),
        home: LoginPage(title: 'Flutter Demo Home Page'),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new LoginPage(),
        });
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      print('${record.loggerName}: ${record.level.name}: ${record.message} ${e != null ? e?.message : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
