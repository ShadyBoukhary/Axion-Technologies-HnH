import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';import 'package:hnh/app/components/user_event_card.dart';
import 'package:hnh/app/pages/user_events/user_events_controller.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';
import 'package:flutter/cupertino.dart';

class UserEventsPage extends View {
  UserEventsPage(routeObserver, {Key key, this.user}) : super(routeObserver: routeObserver, key: key);
  final User user;

  @override
  _UserEventsPageView createState() =>
      _UserEventsPageView(UserEventsController(DataEventRepository(), user));
}

class _UserEventsPageView extends ViewState<UserEventsPage, UserEventsController> {
  _UserEventsPageView(UserEventsController controller) : super(controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        drawer: Drawer(elevation: 8.0, child: HHHConstants.drawer),
        appBar: appBar,
        body: ModalProgressHUD(
            child: getBody(),
            inAsyncCall: controller.isLoading,
            color: UIConstants.progressBarColor,
            opacity: UIConstants.progressBarOpacity));
  }

  Widget getBody() {
    Widget child = controller.events.isNotEmpty
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
    List<UserEventCard> cards = controller.events
        .map((event) => UserEventCard(event, controller.currentUser, true))
        .toList();
    return ListView(
      scrollDirection: Axis.vertical,
      children: cards,
    );
  }
}
