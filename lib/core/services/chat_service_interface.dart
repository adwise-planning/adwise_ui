abstract class ChatService {
  void connect(String authToken);
  void sendMessage(String message);
  void disconnect();
  Stream<String> get messageStream;
}
