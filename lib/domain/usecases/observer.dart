abstract class Observer<T> {
  void onNext(T);
  void onComplete();
  void onError(e);
}