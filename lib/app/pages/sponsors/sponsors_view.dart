import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/components/sponsor_card.dart';
import 'package:hnh/app/pages/sponsors/sponsors_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/data/repositories/data_hhh_repository.dart';
import 'package:hnh/data/repositories/data_sponsor_repository.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SponsorsPage extends View {
  SponsorsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SponsorsPageView createState() => _SponsorsPageView();
}

class _SponsorsPageView extends ViewState<SponsorsPage, SponsorsController> {
  _SponsorsPageView()
      : super(SponsorsController(DataHHHRepository(), DataSponsorRepository(),
            DataAuthenticationRepository()));

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
      controller.sponsors.map((sponsor) => SponsorCard(sponsor)).toList();

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
}
