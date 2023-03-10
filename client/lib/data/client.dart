import 'dart:io';
import 'dart:typed_data';

class SocketClient {
  late Socket _socket;

  final Function(String data) onData;
  final void Function(dynamic error)? onError;
  final Function()? onDone;

  SocketClient({
    required this.onData,
    this.onError,
    this.onDone,
  });

  Future<void> init() async {
    _socket = await Socket.connect('localhost', 3000);

    _socket.listen(
      (Uint8List data) => onData(String.fromCharCodes(data)),
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
}
