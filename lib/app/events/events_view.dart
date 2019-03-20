import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/components/event_card.dart';
import 'package:hnh/app/components/hhDrawer.dart';
import 'package:hnh/app/events/events_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class EventsPage extends StatefulWidget {
  EventsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EventsPageView createState() => _EventsPageView(EventsController());
}

class _EventsPageView extends View<EventsPage> {
  EventsController _controller;
  ScrollController _scrollController;

  _EventsPageView(this._controller);

  void callHandler(Function fn, {Map<String, dynamic> params}) {
    setState(() {
      if (params == null) {
        fn();
      } else {
        fn(params);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        elevation: 8.0,
        child: HhDrawer('Guest User', ''),
      ),
      appBar: AppBar(
        title: Text(
          'Events',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
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
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'See All (12)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            height: 250.0,
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
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Calendar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
