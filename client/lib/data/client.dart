import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class SocketClient {
  late Socket _socket;
  final StreamController<String> _dataStreamController = StreamController.broadcast();
  bool initialized = false;

  Stream<String> get stream => _dataStreamController.stream;

  final void Function(dynamic error)? onError;
  final Function()? onDone;

  SocketClient({
    this.onError,
    this.onDone,
  });

  Future<void> init() async {
    if (initialized) return;

    _socket = await Socket.connect('localhost', 3000);

    _socket.listen(
      (Uint8List data) => _dataStreamController.add(String.fromCharCodes(data)),
      onError: (error) {
        onError?.call(error);

        _socket.destroy();
      },
      onDone: () {
        onDone?.call();

        _socket.destroy();
      },
    );

    initialized = true;
  }

  Future<void> sendMessage(String message) async {
    print('Client: $message');
    _socket.write(message);
  }
}
