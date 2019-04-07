import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/components/event_card.dart';
import 'package:hnh/app/user_events/user_events_controller.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';

class UserEventsPage extends StatefulWidget {
  UserEventsPage(this.routeObserver, {Key key, this.user}) : super(key: key);

  final User user;
  final RouteObserver routeObserver;

  @override
  _UserEventsPageView createState() =>
      _UserEventsPageView(UserEventsController(DataEventRepository(), user));
}

class _UserEventsPageView extends View<UserEventsPage> {
  UserEventsController _controller;

  _UserEventsPageView(this._controller) {
    _controller.refresh = callHandler;
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  void didChangeDependencies() {
    widget.routeObserver.subscribe(_controller, ModalRoute.of(context));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _controller.context = context;
    return Scaffold(
        drawer: Drawer(elevation: 8.0, child: View.drawer),
        appBar: appBar,
        body: ModalProgressHUD(
            child: getBody(),
            inAsyncCall: _controller.isLoading,
            color: UIConstants.progressBarColor,
            opacity: UIConstants.progressBarOpacity));
  }

  Widget getBody() {
    Widget child = _controller.events.isNotEmpty
        ? getEvents()
        : Center(
            child: Text(
            'No saved events.',
            style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w200,
                  ),
          ));
    return Padding(padding: EdgeInsets.only(top: 25), child: child);
  }

  AppBar get appBar => AppBar(
        title: Text(
          'My Events',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      );

  ListView getEvents() {
    List<Padding> cards = _controller.events
        .map((event) => Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: EventCard(event, _controller.currentUser, true)))
        .toList();
    return ListView(
      scrollDirection: Axis.vertical,
      children: cards,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
