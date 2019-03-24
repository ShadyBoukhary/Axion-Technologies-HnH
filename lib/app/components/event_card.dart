import 'package:flutter/material.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/event.dart';

class EventCard extends StatelessWidget {

  final Event _event;

  EventCard(this._event);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 300.0,
            height: MediaQuery.of(context).size.height / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: InkWell(
                splashColor: Colors.black,
                onTap: () => {Navigator.pushNamed(context, '/event')},
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
                onTap: () => {Navigator.pushNamed(context, '/event')},
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
    );
  }
}
