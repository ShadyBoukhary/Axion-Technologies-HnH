import 'package:flutter/material.dart';
import 'package:hnh/domain/entities/sponsor.dart';

class SponsorCard extends StatelessWidget {
  final Sponsor _sponsor;

  SponsorCard(this._sponsor);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          onTap: () => navigate(context),
          child: Stack(
            children: <Widget>[
              getImage(context),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  decoration: decoration,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0), child: sponsorInfo),
                ),
              ),
            ],
          ),
        ),
      );

  BoxDecoration get decoration => BoxDecoration(
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
      );

  Container getImage(context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            _sponsor.imageUrl,
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
      );

  Column get sponsorInfo => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _sponsor.name,
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
                  _sponsor.website,
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


  void navigate(context) => Navigator.pushNamed(context, '/web', arguments: {'title': _sponsor.name, 'url': _sponsor.website});

}
