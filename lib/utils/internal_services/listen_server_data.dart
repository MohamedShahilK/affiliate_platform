// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_print

import 'package:web_socket_channel/io.dart';

void listenToServerData() {
  // Replace 'your-server-url' with the actual URL of your server's WebSocket endpoint
  const serverUrl = 'wss://your-server-url';

  final channel = IOWebSocketChannel.connect(serverUrl);

  channel.stream.listen(
    (message) {
      // Handle the received message here
      // You can process the incoming data or trigger any actions
      //print('Received data from server: $message');
      processDataFromServer(message as String);
    },
    onError: (error) {
      // Handle any WebSocket connection errors here
      //print('WebSocket error: $error');
    },
    onDone: () {
      // Handle the WebSocket connection closure here
      //print('WebSocket connection closed');
    },
  );
}

void processDataFromServer(String data) {
  // Process the received data here
  // Perform any required actions or updates in your Flutter app
  // For example, update UI, update local data, etc.
  //print('Processing data from server: $data');
}
