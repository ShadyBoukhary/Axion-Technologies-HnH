import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/event/event_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';


class EventPage extends StatefulWidget {
  EventPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EventPageView createState() => _EventPageView(EventController(DataEventRepository()));
}

class _EventPageView extends View<EventPage> {
  EventController _controller;

  _EventPageView(this._controller) {
    _controller.refresh = callHandler;
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final String _description =
        "100 MILES IN 100 DEGREES FOR THE 100 YEAR ANNIVERSARY OF WICHITA FALLS.";
    final String _subDescription =
        "Your skills, training, and resolve will be tested. This is not an ordinary ride. It's hell.\nA lot of things are going on during the HHH weekend but there is no way to describe the electrifying experience of the START. Riders begin to assemble as early as 4AM. They are joined by 10,000+ other riders who have trained to complete their chosen distances. All that pent up human energy is unleashed after the American National Anthem, Air Force Fly Over and Cannon Blast. If you are going to ride 100 miles, the best place to do it is at the Hotter’N Hell Hundred!";

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: width,
            height: 250.0,
            child: eventHeader,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Event Title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text(
                  _description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  _subDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding:
                const EdgeInsets.only(right: 30.0, bottom: 20.0, left: 30.0),
            child: signupButton,
          ),
        ],
      ),
    );
  }

  Stack get eventHeader => Stack(
        children: <Widget>[
          Image(
            height: 250.0,
            width: MediaQuery.of(context).size.width,
            image: AssetImage(Resources.event_race),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              BackButton(color: Colors.white),
            ],
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: IconButton(
              icon: Icon(
                Icons.star_border,
              ),
              color: Colors.white,
              iconSize: 35.0,
              onPressed: () => {print('Favorite pressed')},
            ),
          ),
        ],
      );

  GestureDetector get signupButton => GestureDetector(
        onTap: () {
          print('Register for Event clicked');
          //callHandler(_controller.login);
        },
        child: Container(
          height: 50.0,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 38, 39, 1.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
