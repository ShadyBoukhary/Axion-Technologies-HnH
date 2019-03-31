import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/components/event_card.dart';
import 'package:hnh/app/events/events_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EventsPageView createState() => _EventsPageView(
      EventsController(DataAuthenticationRepository(), DataEventRepository()));
}

class _EventsPageView extends View<EventsPage> {
  EventsController _controller;
  
  _EventsPageView(this._controller) {
    _controller.refresh = callHandler;
    WidgetsBinding.instance.addObserver(_controller);
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
            Text(
              'See All (${_controller.upComingEvents.length})',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 5.0),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.red,
                child: Text(
                  _controller.isLoading
                      ? "GU"
                      : _controller.currentUser?.initials,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
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
          onTap: () => {_controller.openEvent(event)},
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
    List<EventCard> cards = _controller.featuredEvents
        .map((event) => EventCard(event, _controller.currentUser))
        .toList();
    return ListView(
      scrollDirection: Axis.horizontal,
      children: cards,
    );
  }

  List<Container> get upcomingEvents => _controller.upComingEvents
      .map((event) => Container(child: getSmallEventCard(event)))
      .toList();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
