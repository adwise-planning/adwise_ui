import 'dart:async';
import 'dart:io';
import 'package:adwise/core/constants/app_constants.dart';
import 'package:adwise/core/services/chat_service_interface.dart';
import 'package:adwise/core/services/logger_service.dart';

class ChatServiceIO implements ChatService {
  WebSocket? _webSocket;
  final StreamController<String> _messageController =
      StreamController<String>.broadcast();

  @override
  Stream<String> get messageStream => _messageController.stream;

  final logger = AppLogger();
  
  @override
  void connect(String authToken) async {
    try {
      // authToken = authToken.isEmpty ? token : authToken;
      // final url = 'wss://websocket-server-7y5w.onrender.com/ws?token=$authToken';
      //final url = 'wss://adwise-service.onrender.com/ws';
      final url = AppConstants.webSocketURL;

      logger.info('Connecting to WebSocket server at: $url');

      _webSocket = await WebSocket.connect(url, headers: {"Authorization": "Bearer $authToken"});

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
