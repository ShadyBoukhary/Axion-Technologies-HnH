import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/components/mini_map.dart';
import 'package:hnh/app/pages/event/event_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';

class EventPage extends View {
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

class _EventPageView extends ViewState<EventPage, EventController> {
  EventController _controller;

  _EventPageView(EventController controller) : super(controller);

  @override
  void initState() {
    // hacky way to display the app after the page and the transition
    // has completely finished. The future delay is just an extra measure
    // to prevent any jittering when calling setstate
    // this makes the page load faster since the google map
    // is only displayed and the UI updated after the page has 
    // already loaded
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            _controller.finishedLoading = true;
          });
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: ModalProgressHUD(
            child: getBody(),
            inAsyncCall: _controller.isLoading,
            color: UIConstants.progressBarColor,
            opacity: 0));
  }

  ListView getBody() {
    List<Widget> children = [
      Container(
        width: MediaQuery.of(context).size.width,
        child: eventHeader,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _controller.event.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
      ),
      Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              _controller.event.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    ];

    // load the map only after the page has already finished loading
    // improve performance on somewhat slow devices
    if (_controller.finishedLoading) {
      children.add(Padding(
        padding: const EdgeInsets.all(15.0),
        child: MiniMap(widget.event),
      ));
    } else {
      children.add(Container(
        height: 265,
        width: 115,
        color: Colors.transparent,
      ));
    }

    children.add(Padding(
      padding:
          const EdgeInsets.only(right: 30.0, bottom: 20.0, left: 30.0, top: 20),
      child: getSignupButton(),
    ));

    return ListView(children: children);
  }

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
              const BackButton(color: Colors.grey),
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
          style: const TextStyle(
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
