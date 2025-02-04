import 'dart:async';
import 'dart:convert';
import 'package:Adwise/core/services/logger_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
//import 'dart:html';

class ChatService {
  late WebSocketChannel _channel;
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;

  final logger = AppLogger();
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imdlbi56QGdtYWlsLmNvbSIsImRldmljZV9pZCI6IngwXzJLMjJQUyIsImVtYWlsIjoiZ2VuLnpAZ21haWwuY29tIiwiZXhwIjoxNzM4NzI1NzQ1LCJpYXQiOjE3Mzg2NDAxNjR9.vULVRnux88fEpIhxYZogUD-PjpjvNgmLmRl2cgeQNbE';

  void connect(String authToken) {
    try {
      
      authToken = authToken.isEmpty ? token : authToken;
      final url = 'wss://websocket-server-7y5w.onrender.com/ws?token=$authToken';

      // Use platform-specific WebSocket implementation
        _channel = WebSocketChannel.connect(
          Uri.parse(url),
        );
      
      logger.info('Connecting to WebSocket server at: $url');

      _channel.stream.listen(
        (message) {
          final decodedMessage = jsonDecode(message);
          _messageController.add(decodedMessage);
        },
        onError: (error) {
          _messageController.addError(error);
        },
        onDone: () {
          _messageController.close();
        },
      );
    } catch (e) {
      _messageController.addError('Failed to connect: $e');
    }
  }

  void sendMessage(String senderId, String receiverId, String content) {
    if (_channel.sink != null) {
      final message = jsonEncode({
        'sender_id': senderId,
        'recipient_id': receiverId,
        'content': content,
        'timestamp': DateTime.now().toIso8601String(),
      });
      
      logger.info('Sender ID: $senderId');
      logger.info('receiver Id: $receiverId');
      logger.info('content: $content');
      logger.info('Sending message: $message');
      _channel.sink.add(message);
      
    } else {
      _messageController.addError('WebSocket connection is not established.');
    }
  }

  void disconnect() {
    if (_channel.sink != null) {
      _channel.sink.close();
    }
    _messageController.close();
  }

  // Helper method to check if the app is running on the web
  bool isWeb() {
    return identical(0, 0.0); // A hack to detect web platform
  }
}