import 'package:hnh/app/abstract/controller.dart';

class HomeController extends Controller {

  int _counter;
  int get counter => _counter;

  HomeController() {
    _counter = 0;
  }
  
  void incrementCounter() {
    _counter++;
  } 
}
