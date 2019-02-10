import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  SplashPageView createState() => SplashPageView(SplashController());
}

class SplashPageView extends State<SplashPage> with SingleTickerProviderStateMixin implements View {

  SplashController _controller;

  AnimationController _animationController;

  SplashPageView(this._controller);

  void callHandler(Function fn) {
    setState(() {
      fn();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}