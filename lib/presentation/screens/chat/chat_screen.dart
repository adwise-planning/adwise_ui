import 'package:Adwise/core/constants/app_constants.dart';
import 'package:Adwise/core/services/chat_service_web.dart';
import 'package:Adwise/core/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String chatId;
  final String recipientName;
  final String authToken;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.recipientName,
    required this.authToken,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  late ChatService _chatService;
  

  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
    _chatService.connect(widget.authToken);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatService.disconnect();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _chatService.sendMessage('gen.z@gmail.com','gen.y@gmail.com', message);
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
            child: StreamBuilder(
              stream: _chatService.messageStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data as String; // Adjust based on API response

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: 10, // Mock data
                  itemBuilder: (context, index) {
                    final isMe = index % 2 == 0; // Mock sender
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
                          messages,
                          style: TextStyle(
                            color: isMe ? Colors.white : AppConstants.primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
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