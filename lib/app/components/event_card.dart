import 'package:flutter/material.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';

class EventCard extends StatelessWidget {

  final Event _event;
  final User _user;
  final bool isUserEvent;  // indicates whether the event card is being used for user events for styling purposes

  EventCard(this._event, this._user, [this.isUserEvent]);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Padding(
        padding: EdgeInsets.only(right: (isUserEvent == null ? 15.0 : 0)),
        child: Stack(
          children: <Widget>[
            Container(
              width:  isUserEvent == null ? MediaQuery.of(context).size.width / 1.4 : MediaQuery.of(context).size.width / 1.15,
              height: MediaQuery.of(context).size.height / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: InkWell(
                  onTap: () => { navigate(context) },
                  splashColor: Colors.black,
                  child: Image.network(
                    _event.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: 300.0,
                height: (MediaQuery.of(context).size.height / 4) / 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: InkWell(
                  splashColor: Colors.black,
                  onTap: () => { navigate(context) },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _event.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                _event.description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigate(context) { 
    var args = {'event': _event, 'user': _user};
    args['isUserEvent'] = isUserEvent != null ? true : false;
    Navigator.pushNamed(context, '/event', arguments: args);
  }

}
