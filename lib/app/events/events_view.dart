import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/components/event_card.dart';
import 'package:hnh/app/components/hhDrawer.dart';
import 'package:hnh/app/events/events_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_hhh_repository.dart';
import 'package:hnh/data/repositories/data_sponsor_repository.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EventsPageView createState() => _EventsPageView(EventsController(
      DataHHHRepository(),
      DataSponsorRepository(),
      DataAuthenticationRepository()));
}

class _EventsPageView extends View<EventsPage> {
  EventsController _controller;

  _EventsPageView(this._controller) {
    _controller.refresh = callHandler;
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 8.0,
        child: _controller.isLoading
            ? HhDrawer('Guest User', '')
            : HhDrawer(_controller.currentUser.fullName,
                _controller.currentUser.email),
      ),
      appBar: appBar,
      body: ListView(
        children: <Widget>[
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
            padding: EdgeInsets.only(left: 20.0),
            height: MediaQuery.of(context).size.height / 4,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                EventCard(
                  'THE "RIDE"',
                  'A lot of things are going on during the HHH weekend but there is no way to describe the electrifying experience of the START. Riders begin to assemble as early as 4AM. They are joined by 10,000+ other riders who have trained to complete their chosen distances. All that pent up human energy is unleashed after the American National Anthem, Air Force Fly Over and Cannon Blast. If you are going to ride 100 miles, the best place to do it is at the Hotter’N Hell Hundred!',
                  'Location',
                  'Date',
                  'Time',
                  Resources.event_race,
                ),
                SizedBox(width: 20.0),
                EventCard(
                  'SPAGHETTI DINNER',
                  'The Spaghetti dinner is presented by the members of the North Texas Restaurant Association with all proceeds going to benefit their charities primarily the Wichita Falls Interfaith Ministries.',
                  'Location',
                  'Date',
                  'Time',
                  Resources.event_spaghetti,
                ),
                SizedBox(width: 20.0),
                EventCard(
                  'CONSUMER SHOW',
                  'The 2019 HHH Consumer Show will be in the MPEC Exhibit Hall. There will be over 90 vendors offering all sorts of cycling related products.',
                  'Location',
                  'Date',
                  'Time',
                  Resources.event_consumer,
                ),
              ],
            ),
          ),
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
                  'See All (12)',
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
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
          Container(
            child: smallEventCard,
          ),
        ],
      ),
    );
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

  Card get smallEventCard => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Container(
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
            title: Text(
              'Event',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Description for Event',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
