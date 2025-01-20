// native_socket.dart
import 'dart:io'; // For WebSocket on mobile platforms

Future<WebSocket> createWebSocket(String url, {Map<String, String>? headers}) async {
  return await WebSocket.connect(url, headers: headers);
}