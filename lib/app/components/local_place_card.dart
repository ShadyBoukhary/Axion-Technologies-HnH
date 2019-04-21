import 'package:flutter/material.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:logging/logging.dart';

class LocalPlaceCard extends StatelessWidget {
  final LocalPlace _place;
 // final GlobalKey<ScaffoldState> key;

  LocalPlaceCard(this._place);//: key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.all(3.0),
      child: Stack(
        children: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250.0,
              child: getCard(context)),
        ],
      ),
    );
  }

  Card getCard(context) => Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 8.0,
        child: InkWell(
          splashColor: Colors.black,
          onTap: () => open(),
          child: Stack(
            children: <Widget>[
              getImage(context),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0), child: placeInfo),
                ),
              ),
            ],
          ),
        ),
      );

  Container getImage(context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            _place.hasPhotoReference ? _place.photo : _place.icon,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            colorBlendMode: BlendMode.srcOver,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      );

  Widget get placeInfo => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  _place.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  _place.address,
                  textAlign: TextAlign.center,
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
      );

  void open() => launchMaps(_place.coordinates, Logger('LocalPlaceCard'), key);
}
