import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/splash/splash_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/device/repositories/device_location_repository.dart';
class SplashPage extends StatefulWidget {
  SplashPage();
  @override
  SplashPageView createState() => SplashPageView(SplashController(DataAuthenticationRepository(), DeviceLocationRepository()));
}

class SplashPageView extends View<SplashPage> with SingleTickerProviderStateMixin {
  SplashController _controller;

  AnimationController _animationController;
  Animation<double> _animation;

  SplashPageView(this._controller);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _controller.initAnimation(_animationController, _animation);
    _controller.refresh = callHandler;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.context = context;
    return Scaffold(body: body);
  }

  // Scaffold body
  Stack get body => Stack(
        children: <Widget>[
          background,
          logo,
        ],
      );

  Positioned get background => Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          Resources.background,
          fit: BoxFit.fill,
        ),
      );

  Positioned get logo => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: 0.0,
        right: 0.0,
        child: Column(
          children: <Widget>[
            FadeTransition(
                opacity: _animation,
                child: Image(
                  image: AssetImage(Resources.logo),
                )),
          ],
        ),
      );
}
