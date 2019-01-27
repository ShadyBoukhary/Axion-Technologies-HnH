import 'package:rxdart/rxdart.dart';
import 'package:hnh/domain/usecases/observer.dart';
import 'dart:async';

abstract class UseCase<T, Params> {
  CompositeSubscription _disposables;

  UseCase() {
    _disposables = CompositeSubscription();
  }

  Future<Observable<T>> buildUseCaseObservable(Params params);

  void execute(Observer<T> observer, Params params) async {
    final StreamSubscription subscription = (await buildUseCaseObservable(params))
      .listen(observer.onNext, onDone: observer.onComplete, onError: observer.onError);
    _addSubscription(subscription);

  }

  void dispose() {
    if (!_disposables.isDisposed) {
      _disposables.dispose();
    }
  }

  void _addSubscription(StreamSubscription subscription) {
    _disposables.add(subscription);
  }
}

abstract class Completable<Params> extends UseCase<void, Params> {
  Future<Observable<void>> buildUseCaseObservable(Params params);
}