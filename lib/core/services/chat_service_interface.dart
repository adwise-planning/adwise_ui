import 'dart:async';

abstract class ChatServiceInterface {
  Stream<String> get messageStream;

  void connect(String authToken);
  void sendMessage(String message);
  void disconnect();
}
