import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/components/user_event_card.dart';
import 'package:hnh/app/pages/user_events/user_events_controller.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';
import 'package:flutter/cupertino.dart';

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
    _controller.initController(scaffoldKey, callHandler);
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  void didChangeDependencies() {
    widget.routeObserver.subscribe(_controller, ModalRoute.of(context));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
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
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No saved events. Click on the star in the event page to save.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19.0,
                fontWeight: FontWeight.w200,
              ),
              textAlign: TextAlign.center,
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
    List<UserEventCard> cards = _controller.events
        .map((event) => UserEventCard(event, _controller.currentUser, true))
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
