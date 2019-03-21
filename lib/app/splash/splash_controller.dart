import 'package:flutter/animation.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/splash/splash_presenter.dart';
import 'package:flutter/material.dart';

class SplashController extends Controller {
  SplashPresenter _splashPresenter;
  
  SplashController(authRepo) {
    _splashPresenter = SplashPresenter(authRepo);
    initListeners();
    getAuthStatus();
  }

  /// Initializes [animation] for the view using a given [controller]
  void initAnimation(AnimationController controller, Animation animation) {
    animation.addStatusListener((status) {
      if (!isLoading) {
        controller.stop(canceled: true);
      } else if (status == AnimationStatus.completed) {
        controller.reverse();

      } else if (status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    controller.forward();
  }

  void authStatusOnNext(bool isAuth) {
    String page = isAuth ? '/home' : '/login';
    Navigator.of(context).pushReplacementNamed(page);
  }

  void getAuthStatus() async {
    isLoading = true;
    // so the animation can be seen
    Future.delayed(Duration(seconds: 3), _splashPresenter.getAuthStatus);
  }

  void initListeners() {
    _splashPresenter.getAuthStatusOnNext = authStatusOnNext;
    _splashPresenter.getAuthStatusOnComplete = () => dismissLoading();
  }

  void dispose() => _splashPresenter.dispose();
}
