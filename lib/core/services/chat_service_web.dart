import 'dart:async';
import 'package:Adwise/core/services/chat_service_interface.dart';
import 'package:Adwise/core/services/logger_service.dart';
import 'dart:html' as html; // Import for Dart web

class ChatServiceWeb implements ChatService {
  html.WebSocket? _webSocket;
  final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  Stream<String> get messageStream => _messageController.stream;

  final logger = AppLogger();

  void connect(String authToken) async {
    try {
      // final url = 'wss://adwise-service.onrender.com/ws';
      final url = 'ws://websocket-server-7y5w.onrender.com/ws?token=';

      logger.info('Connecting to WebSocket server at: $url');

      // _webSocket = html.WebSocket(url, protocols: null, headers: {"Authorization": "Bearer $authToken"});
      _webSocket = await html.WebSocket(url + authToken);

      _webSocket!.onMessage.listen((html.MessageEvent message) {
        logger.info('Received message: ${message.data}');
        _messageController.add(message.data as String);
      });

      _webSocket!.onError.listen((html.Event error) {
        logger.error('WebSocket Error: $error');
        _messageController.addError(error);
      });

      _webSocket!.onClose.listen((html.CloseEvent event) {
        logger.warn('WebSocket connection closed.');
        _messageController.close();
      });

      logger.info('WebSocket connected successfully (Web).');
    } catch (e) {
      logger.error('Failed to connect to WebSocket: $e');
      _messageController.addError('Connection failed: $e');
    }
  }

  void sendMessage(String message) {
    if (_webSocket != null && _webSocket!.readyState == html.WebSocket.OPEN) {
      logger.info('Sending message: $message');
      _webSocket!.send(message);
    } else {
      logger.warn('Cannot send message, WebSocket is not connected.');
    }
  }

  void disconnect() {
    _webSocket?.close();
    _messageController.close();
  }
}