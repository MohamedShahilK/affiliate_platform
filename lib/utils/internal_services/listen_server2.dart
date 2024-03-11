// ignore_for_file: avoid_print, inference_failure_on_untyped_parameter, lines_longer_than_80_chars

import 'dart:convert';
import 'dart:io';

Future<void> listenToServerData() async {
  // Replace 'your-server-url' with the actual URL of your server's SSE endpoint
  final serverUrl = Uri.parse('https://your-server-url');

  try {
    final request = await HttpClient().getUrl(serverUrl);
    final response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      response.transform(utf8.decoder).listen(
        (data) {
          // Data was received from the server
          // You can process the received data here
          //print('Data added to server: $data');
          processDataFromServer(data);
        },
        onError: (error) {
          // Handle any errors during data reception
          //print('Error receiving data: $error');
        },
        onDone: () {
          // Handle the closure of the SSE connection
          //print('SSE connection closed');
        },
      );
    } else {
      // There was an error while connecting to the SSE endpoint
      //print(
      //   'Failed to connect to SSE endpoint. Status code: ${response.statusCode}',
      // );
    }
  } catch (error) {
    // An error occurred while connecting to the SSE endpoint
    //print('Error connecting to SSE endpoint: $error');
  }
}

void processDataFromServer(String data) {
  // Process the received data here
  // Perform any required actions or updates in your Flutter app
  // For example, update UI, update local data, etc.
  //print('Processing data from server: $data');
}
