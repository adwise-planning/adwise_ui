import 'dart:async';
import 'dart:io';
import 'chat_service_interface.dart';
import 'package:Adwise/core/services/logger_service.dart';

class ChatServiceIO implements ChatServiceInterface {
  WebSocket? _webSocket;
  final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  Stream<String> get messageStream => _messageController.stream;

  final logger = AppLogger();
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imdlbi55QGdtYWlsLmNvbSIsImRldmljZV9pZCI6IngwXzJLMjJQUyIsImVtYWlsIjoiZ2VuLnlAZ21haWwuY29tIiwiZXhwIjoxNzM4NzIwMzg0LCJpYXQiOjE3Mzg2MzQxODJ9.tSsE2KYpjT_L8Ntcq5hzyuZ6yk0KdOVoQ_U8M_JKq2o';

  @override
  void connect(String authToken) async {
    try {
      authToken = authToken.isEmpty ? token : authToken;
      final url = 'wss://websocket-server-7y5w.onrender.com/ws?token=$authToken';

      logger.info('Connecting to WebSocket server at: $url');

      _webSocket = await WebSocket.connect(url);

      _webSocket!.listen(
        (message) {
          logger.info('Received message: $message');
          _messageController.add(message);
        },
        onError: (error) {
          logger.error('WebSocket Error: $error');
          _messageController.addError(error);
        },
        onDone: () {
          logger.warn('WebSocket connection closed.');
          _messageController.close();
        },
      );

      logger.info('WebSocket connected successfully (Mobile/Desktop).');
    } catch (e) {
      logger.error('Failed to connect to WebSocket: $e');
      _messageController.addError('Connection failed: $e');
    }
  }

  @override
  void sendMessage(String message) {
    if (_webSocket != null && _webSocket!.readyState == WebSocket.open) {
      logger.info('Sending message: $message');
      _webSocket!.add(message);
    } else {
      logger.warn('Cannot send message, WebSocket is not connected.');
    }
  }

  @override
  void disconnect() {
    _webSocket?.close();
    _messageController.close();
  }
}
