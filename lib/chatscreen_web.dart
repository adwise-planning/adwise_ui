import 'dart:convert';
import 'dart:html'; // Web-specific WebSocket support
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String status;
  final String authToken; // Authorization token

  const ChatScreen({
    super.key,
    required this.username,
    required this.status,
    required this.authToken,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Store messages with metadata

  WebSocket? _socket; // WebSocket instance

  @override
  void initState() {
    super.initState();
    _connectWebSocket(); // Connect to WebSocket when the screen is initialized
  }

  // Connect WebSocket (using dart:html WebSocket for web)
  Future<void> _connectWebSocket() async {
    try {
      // Establish WebSocket connection with custom headers (For Web only)
      final uri = Uri.parse('wss://websocket-server-7y5w.onrender.com/ws?token=${widget.authToken}');

      _socket = WebSocket(uri.toString());  // Using WebSocket from dart:html

      // Listen for incoming messages
      _socket!.onMessage.listen((event) {
        final decodedMessage = jsonDecode(event.data); // Decode the JSON
        print('Returned Message: $decodedMessage');
        if (decodedMessage['recipient_id'] == widget.username) {
          setState(() {
            _messages.insert(0, decodedMessage); // Add received message to the list
          });
        }
      });

      _socket!.onError.listen((error) {
        debugPrint('WebSocket Error: $error');
      });

      _socket!.onClose.listen((event) {
        debugPrint('WebSocket connection closed');
      });
    } catch (e) {
      debugPrint('Failed to connect to WebSocket: $e');
    }
  }

  // Send a message through WebSocket
  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty && _socket != null) {
      final messageData = {
        'sender_id': widget.username,
        'recipient_id': 'HB', // Replace with dynamic receiver or chat group
        'content': message,
        'timestamp': DateTime.now().toIso8601String(),
      };
      _socket!.send(jsonEncode(messageData)); // Send JSON message over WebSocket
      print('Message sent: $messageData');
      setState(() {
        _messages.insert(0, messageData); // Add sent message to the list
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _socket?.close(); // Close the WebSocket connection
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(47, 60, 79, 1),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://www.programiz.com/blog/content/images/2022/03/Banner-Image-1.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.status,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSentByMe = message['sender_id'] == widget.username;

                // Align the message: sent messages to the right, received to the left
                return Align(
                  alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft, // <-- Changed
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // Change the bubble color based on whether it's sent or received
                      color: isSentByMe ? const Color(0xFFDCF8C6) : Colors.grey[300], // <-- Changed
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, // <-- Changed
                      children: [
                        Text(
                          message['content'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          message['timestamp'],
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF075E54)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
      home: ChatScreen(
        username: 'HB',
        status: 'Online',
        authToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiSEIiLCJleHAiOjE3MzczOTQwMTN9.ZnuxjYpe171utd81CMFiTOO6AcYx8mM-PKMmcqGalPY', // Pass your auth token
      ),
      debugShowCheckedModeBanner: false,
    ));
