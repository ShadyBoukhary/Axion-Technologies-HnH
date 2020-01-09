import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/components/event_card.dart';
import 'package:hnh/app/pages/events/events_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EventsPage extends View {
  EventsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EventsPageView createState() => _EventsPageView();
}

class _EventsPageView extends ViewState<EventsPage, EventsController> {
  _EventsPageView()
      : super(EventsController(
            DataAuthenticationRepository(), DataEventRepository()));

  @override
  Widget buildPage() {
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

  ListView getBody() {
    List<Widget> children = [
      SizedBox(height: 10.0),
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Featured Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10.0),
      Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          height: MediaQuery.of(context).size.height / 4,
          child: getFeaturedEvents()),
      SizedBox(height: 20.0),
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Upcoming Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10.0),
    ];
    List<Container> events = upcomingEvents;
    if (events.length > 0) {
      children.addAll(upcomingEvents);
    }
    return ListView(children: children);
  }

  AppBar get appBar => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );

  Card getSmallEventCard(event) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        child: InkWell(
          splashColor: Colors.redAccent,
          onTap: () => {controller.openEvent(event)},
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              title: Text(
                event.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                event.description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios)),
        ),
      ),
    );
  }

  ListView getFeaturedEvents() {
    List<EventCard> cards = controller.featuredEvents
        .map((event) => EventCard(event, controller.currentUser))
        .toList();
    return ListView(
      scrollDirection: Axis.horizontal,
      children: cards,
    );
  }

  List<Container> get upcomingEvents => controller.upComingEvents
      .map((event) => Container(child: getSmallEventCard(event)))
      .toList();
}
