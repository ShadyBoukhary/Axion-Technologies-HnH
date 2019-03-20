import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/events/events_presenter.dart';

class EventsController extends Controller {
  EventsPresenter _eventsPresenter;

  EventsController() {
    initListeners();
  }

  void initListeners() {}
}