import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/event/event_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EventPage extends StatefulWidget {
  final Event event;
  final User user;
  final bool isUserEvent;

  EventPage(
      {Key key,
      this.title,
      @required this.event,
      @required this.user,
      @required this.isUserEvent})
      : super(key: key);

  final String title;

  @override
  _EventPageView createState() => _EventPageView(
      EventController(DataEventRepository(), event, user, isUserEvent));
}

class _EventPageView extends View<EventPage> {
  EventController _controller;

  _EventPageView(this._controller) {
    _controller.refresh = callHandler;
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  Widget build(BuildContext context) {
    _controller.context = context;
    return Scaffold(
        body: ModalProgressHUD(
            child: body,
            inAsyncCall: _controller.isLoading,
            color: UIConstants.progressBarColor,
            opacity: UIConstants.progressBarOpacity));
  }

  ListView get body => ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: eventHeader,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _controller.event.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text(
                  _controller.event.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding:
                const EdgeInsets.only(right: 30.0, bottom: 20.0, left: 30.0),
            child: getSignupButton(),
          ),
        ],
      );

  Stack get eventHeader => Stack(
        children: <Widget>[
          Image.network(
            _controller.event.imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              BackButton(color: Colors.grey),
            ],
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: IconButton(
              icon: Icon(
                _controller.isRegistered ? Icons.star : Icons.star_border,
              ),
              color: Colors.red,
              iconSize: 40.0,
              onPressed: _controller.handleRegistration,
            ),
          ),
        ],
      );

  GestureDetector getSignupButton() {
    String title = widget.isUserEvent ? 'Start Navigation' : 'Signup';
    var handler = widget.isUserEvent
        ? _controller.onStartNavigationPressed
        : _controller.onSignUpPressed;
    return GestureDetector(
      onTap: handler,
      child: Container(
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(230, 38, 39, 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.4),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
