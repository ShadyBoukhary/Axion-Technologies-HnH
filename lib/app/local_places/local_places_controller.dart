import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/local_places/local_places_presenter.dart';
import 'package:hnh/domain/entities/local_place.dart';

class LocalPlacesController extends Controller {
  LocalPlacesPresenter _placesPresenter;
  List<LocalPlace> _places;
  List<LocalPlace> get places => _places;
  List<LocalPlace> get restaurants => _places.where((place) => place.type == LocalPlaceType.restaurant).toList();
  List<LocalPlace> get hotels => _places.where((place) => place.type == LocalPlaceType.hotel).toList();

  LocalPlacesController(localPlacesRepo, locationRepo) {
    _placesPresenter =  LocalPlacesPresenter(localPlacesRepo, locationRepo);
    _places = List<LocalPlace>();
    initListeners();
    startLoading();
    retrieveData();
  }

  void initListeners() {
    _placesPresenter.getLocalPlacesOnNext = (List<LocalPlace> places) => _places = places;

    _placesPresenter.getLocalPlacesOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _placesPresenter.getLocalPlacesOnComplete = () => dismissLoading();
  }

  void retrieveData() {
    _placesPresenter.getLocalPlaces();
  }

  void dispose() {
    isMounted = false;
    _placesPresenter.dispose();
  }
}