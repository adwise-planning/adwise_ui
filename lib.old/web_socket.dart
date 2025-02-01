// web_socket.dart
import 'dart:html'; // For WebSocket on web

WebSocket createWebSocket(String url) {
  return WebSocket(url);
}
