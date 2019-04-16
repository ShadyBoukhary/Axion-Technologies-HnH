import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/components/sponsor_card.dart';
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
    _controller.initController(scaffoldKey, callHandler);
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
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
    ];

    // get all events and add them to view
    List<SponsorCard> sponsors = sponsorCards;
    if (sponsors.length > 0) {
      children.addAll(sponsors);
    }
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0), children: children);
  }

  List<SponsorCard> get sponsorCards =>
      _controller.sponsors.map((sponsor) => SponsorCard(sponsor)).toList();

  AppBar get appBar => AppBar(
        title: Text(
          'Sponsors',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
