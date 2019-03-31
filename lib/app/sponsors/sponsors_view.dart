import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/components/sponsor_card.dart';
import 'package:hnh/app/components/hhDrawer.dart';
import 'package:hnh/app/sponsors/sponsors_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_hhh_repository.dart';
import 'package:hnh/data/repositories/data_sponsor_repository.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';

class SponsorsPage extends StatefulWidget {
  SponsorsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SponsorsPageView createState() => _SponsorsPageView(SponsorsController(
      DataHHHRepository(),
      DataSponsorRepository(),
      DataAuthenticationRepository()));
}

class _SponsorsPageView extends View<SponsorsPage> {
  SponsorsController _controller;

  _SponsorsPageView(this._controller) {
    _controller.refresh = callHandler;
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Sponsors',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ];

    // get all events and add them to view
    List<SponsorCard> sponsors = sponsorCards;
    if (sponsors.length > 0) {
      children.addAll(sponsors);
    }
    return ListView(padding: EdgeInsets.symmetric(horizontal: 10.0), children: children);
  }

  List<SponsorCard> get sponsorCards => _controller.sponsors.map((sponsor) => SponsorCard(sponsor)).toList();

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
