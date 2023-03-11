import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class SocketClient {
  late Socket _socket;
  final StreamController<String> _streamController = StreamController.broadcast();

  Stream<String> get stream => _streamController.stream;

  final void Function(dynamic error)? onError;
  final Function()? onDone;

  SocketClient({
    required Function(String data) onData,
    this.onError,
    this.onDone,
  }) {
    stream.listen((data) => onData(data));
  }

  Future<void> init() async {
    _socket = await Socket.connect('localhost', 3000);

    _socket.listen(
      (Uint8List data) => _streamController.add(String.fromCharCodes(data)),
      onError: (error) {
        onError?.call(error);

        _socket.destroy();
      },
      onDone: () {
        onDone?.call();

        _socket.destroy();
      },
    );
  }

  Future<void> sendMessage(String message) async {
    print('Client: $message');
    _socket.write(message);
  }

  void dispose() {
    _socket.destroy();
  }
}
