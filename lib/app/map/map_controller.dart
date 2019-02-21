import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/map/map_presenter.dart';

class MapController extends Controller {
  MapPresenter _mapPresenter;

  MapController() {
    initListeners();
  }

  void initListeners() {}
}
