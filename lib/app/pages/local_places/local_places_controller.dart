import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/local_places/local_places_presenter.dart';
import 'package:hnh/app/utils/constants.dart';
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
    loadOnStart();
    retrieveData();
  }

  void initListeners() {
    _placesPresenter.getLocalPlacesOnNext = (List<LocalPlace> places) => _places = places;

    _placesPresenter.getLocalPlacesOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.toString(), isError: true);
    };

    _placesPresenter.getLocalPlacesOnComplete = () => dismissLoading();
  }

  void retrieveData() {
    _placesPresenter.getLocalPlaces();
  }

  @override
  void dispose() {
    _placesPresenter.dispose();
    super.dispose();
  }
}