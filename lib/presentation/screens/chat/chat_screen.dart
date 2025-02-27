import 'package:Adwise/core/constants/app_constants.dart';
import 'package:Adwise/core/services/chat_service_web.dart';
import 'package:Adwise/core/services/logger_service.dart';
import 'package:Adwise/core/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 
class ChatScreen extends ConsumerStatefulWidget {
  final String recipientId;
  final String recipientName;
  final String authToken;
  final String uuid;


  const ChatScreen({
    super.key,
    required this.recipientId,
    required this.recipientName,
    required this.authToken,
    required this.uuid,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  late ChatService _chatService;
  final logger = AppLogger();
  
  List<Map<String, dynamic>> _messages = []; // List to store messages

  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
    print("Chat screen initialized with recipientId: ${widget.recipientId}, recipientName: ${widget.recipientName}, authToken: ${widget.authToken}, userId: ${widget.uuid}");

    _chatService.connect(widget.authToken);

    // Listen for incoming messages
    _chatService.messageStream.listen((message) {
      setState(() {
        _messages.add(message); // Store incoming messages
      });
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatService.disconnect();
    super.dispose();
  }

  void _sendMessage() {
    print("Chat screen initialized with recipientId: ${widget.recipientId}, recipientName: ${widget.recipientName}, authToken: ${widget.authToken}, userId: ${widget.uuid}");
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      final message = {
        'sender_id': widget.uuid,
        'recipient_id': widget.recipientId, // Use recipientId as recipientId
        'content': messageText,
        'timestamp': DateTime.now().toIso8601String(),
      };

      _chatService.sendMessage(
        widget.uuid,
        widget.recipientId,
        messageText,
      );

      setState(() {
        _messages.add(message); // Add sent message
      });

      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Chat screen initialized with recipientId: ${widget.recipientId}, recipientName: ${widget.recipientName}, authToken: ${widget.authToken}, userId: ${widget.uuid}");
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipientName),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['sender_id'] == widget.uuid;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe
                          ? AppConstants.accentColor
                          : (isDarkMode ? Colors.grey[800] : Colors.grey[200]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['content'],
                      style: TextStyle(
                        color: isMe ? Colors.white : AppConstants.primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(8),
            color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
            child: Row(
              children: [
                // Text Field
                Expanded(
                  child: CustomTextFormField(
                    controller: _messageController,
                    hintText: 'Type a message...',
                    isDarkMode: isDarkMode,
                    borderRadius: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),

                // Send Button
                IconButton(
                  onPressed: _messageController.text.trim().isEmpty
                      ? null
                      : _sendMessage,
                  icon: const Icon(Icons.send),
                  color: AppConstants.accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
