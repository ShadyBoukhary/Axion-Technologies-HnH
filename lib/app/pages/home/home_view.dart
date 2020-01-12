import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/components/countdown.dart';
import 'package:hnh/app/pages/home/home_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/data/repositories/data_hhh_repository.dart';
import 'package:hnh/data/repositories/data_sponsor_repository.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomePage extends View {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageView createState() => HomePageView();
}

class HomePageView extends ViewState<HomePage, HomeController> {
  HomePageView()
      : super(HomeController(DataHHHRepository(), DataSponsorRepository(),
            DataAuthenticationRepository()));

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      drawer: Drawer(elevation: 8.0, child: HHHConstants.drawer),
      appBar: appBar,
      body: ModalProgressHUD(
          child: getbody(),
          inAsyncCall: controller.isLoading,
          opacity: UIConstants.progressBarOpacity,
          color: UIConstants.progressBarColor),
    );
  }

  AppBar get appBar => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );

  ListView getbody() {
    List<Widget> children = [
      SizedBox(height: 60.0),
      logoContainer,
      subtitleColumn,
    ];

    if (!controller.isLoading && controller.eventTime != null) {
      children.add(Countdown(controller.eventTime));
    }
    return ListView(children: children);
  }

  Container get logoContainer => Container(
        width: double.infinity,
        height: 200.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image(
            image: AssetImage(Resources.logo),
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      );

  Column get subtitleColumn => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "HELL",
                      style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 88.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 15.0,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 5.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                          Shadow(
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "The Centennial \nRide From",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3.0,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 3.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                        Shadow(
                          offset: Offset(0.0, 5.0),
                          blurRadius: 8.0,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
