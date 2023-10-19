import 'dart:async';

class CepServiceNotifier {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get onCepServiceCalled => _controller.stream;

  void notify() {
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}

final cepServiceNotifier = CepServiceNotifier();
