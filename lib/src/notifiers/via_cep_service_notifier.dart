import 'dart:async';

class ViaCepServiceNotifier {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get onViaCepServiceCalled => _controller.stream;

  void notify() {
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}

final viaCepServiceNotifier = ViaCepServiceNotifier();
