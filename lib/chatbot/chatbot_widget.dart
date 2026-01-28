import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'chat_message.dart';
import 'chatbot_service.dart';

class ChatBotWidget extends StatefulWidget {
  const ChatBotWidget({super.key});

  @override
  State<ChatBotWidget> createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Add welcome message
    _addBotMessage('Hello! How can I help you explore Mauritius today?');
  }

  @override
  void dispose() {
    _textController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleChat() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _sendMessage(String text, String languageCode) {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: text.trim(),
      type: MessageType.user,
    );

    setState(() {
      _messages.add(userMessage);
      _textController.clear();
    });

    // Get bot response
    Future.delayed(const Duration(milliseconds: 500), () {
      final response = ChatBotService.getResponse(text, languageCode);
      _addBotMessage(response);
    });
  }

  void _addBotMessage(String text) {
    final botMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: text,
      type: MessageType.bot,
    );

    setState(() {
      _messages.add(botMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final t = langProvider.translate;

    return Positioned(
      bottom: 90,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isExpanded)
            SizeTransition(
              sizeFactor: _animation,
              child: Container(
                width: 320,
                height: 400,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.support_agent,
                                color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              t['chatBotTitle'] ?? 'Travel Assistant',
                              style: AppTextStyles.h4.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: _toggleChat,
                          ),
                        ],
                      ),
                    ),

                    // Messages
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        reverse: true,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message =
                              _messages[_messages.length - 1 - index];
                          return _buildMessage(message);
                        },
                      ),
                    ),

                    // Input
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                hintText: t['chatBotHint'] ??
                                    'Ask me anything...',
                                hintStyle: AppTextStyles.bodySmall,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              onSubmitted: (text) =>
                                  _sendMessage(text, langProvider.languageCode),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: IconButton(
                              icon: const Icon(Icons.send,
                                  color: Colors.white, size: 20),
                              onPressed: () => _sendMessage(
                                  _textController.text,
                                  langProvider.languageCode),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Floating Action Button
          FloatingActionButton(
            onPressed: _toggleChat,
            backgroundColor: AppColors.primary,
            child: Icon(
              _isExpanded ? Icons.close : Icons.chat,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    final isUser = message.type == MessageType.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryLight,
              child: Icon(Icons.smart_toy, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.message,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isUser ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}