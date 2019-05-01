import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/pages/local_places/local_places_controller.dart';
import 'package:hnh/app/pages/local_places/local_places_tabs.dart';
import 'package:hnh/data/repositories/data_local_places_repository.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/device/repositories/device_location_repository.dart';
import 'package:flutter/cupertino.dart';

class LocalPlacesPage extends StatefulWidget {
  LocalPlacesPage({Key key}) : super(key: key);

  @override
  _LocalPlacesPageView createState() =>
      _LocalPlacesPageView(LocalPlacesController(
          DataLocalPlacesRepository(), DeviceLocationRepository()));
}

class _LocalPlacesPageView extends View<LocalPlacesPage> {
  LocalPlacesController _controller;

  _LocalPlacesPageView(this._controller) {
    _controller.initController(scaffoldKey, callHandler);
    WidgetsBinding.instance.addObserver(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: scaffoldKey,
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          drawer: Drawer(elevation: 8.0, child: View.drawer),
          appBar: appBar,
          body: ModalProgressHUD(
              child: getBody(),
              inAsyncCall: _controller.isLoading,
              color: UIConstants.progressBarColor,
              opacity: UIConstants.progressBarOpacity)),
    );
  }

  Widget getBody() {
    return TabBarView(
      children: [
        RestaurantsTab(_controller.restaurants),
        HotelsTab(_controller.hotels),
      ],
    );
  }


  AppBar get appBar => AppBar(
        title: Text(
          'Local Places',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.restaurant)),
            Tab(icon: Icon(Icons.local_hotel)),
          ],
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
