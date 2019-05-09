import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/splash/splash_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/device/repositories/device_location_repository.dart';

class SplashPage extends View {
  SplashPage();
  @override
  SplashPageView createState() => SplashPageView(SplashController(DataAuthenticationRepository(), DeviceLocationRepository()));
}

class SplashPageView extends ViewState<SplashPage, SplashController> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _animation;

  SplashPageView(SplashController controller) : super(controller);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    controller.initAnimation(_animationController, _animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: globalKey, body: body);
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
                  width: 200.0,
                )),
          ],
        ),
      );
}
