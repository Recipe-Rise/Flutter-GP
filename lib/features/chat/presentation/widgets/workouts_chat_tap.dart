import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/features/chat/data/models/chat_message.dart';
import 'package:fitfork_gp/features/chat/presentation/view_models/workout_chat_view_model.dart';
import 'package:fitfork_gp/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:fitfork_gp/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class WorkoutsChatTab extends StatefulWidget {
  const WorkoutsChatTab({super.key});

  @override
  State<WorkoutsChatTab> createState() => _WorkoutsChatTabState();
}

class _WorkoutsChatTabState extends State<WorkoutsChatTab> {
  final WorkoutChatViewModel _viewModel = WorkoutChatViewModel();
  final ScrollController _scrollController = ScrollController();
  bool _showTypingIndicator = false;

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);

    if (_viewModel.messages.isEmpty) {
      _viewModel.addMessage(
        ChatMessage(
          text:
              'Hi there! I am your workout assistant. Tell me about your fitness goals, and I will help you build a personalized workout plan!',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {
      _showTypingIndicator = _viewModel.isLoading;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Image.asset(AssetsData.first),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                itemCount:
                    _viewModel.messages.length + (_showTypingIndicator ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _viewModel.messages.length) {
                    final message = _viewModel.messages[index];
                    return ChatMessageBubble(
                      message: message,
                      showAvatar: !message.isUser,
                    );
                  } else {
                    // Typing indicator
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.fitness_center,
                                color: Theme.of(context).primaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              children: [
                                _buildDot(1),
                                _buildDot(2),
                                _buildDot(3),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ChatInputField(
            hintText: 'Ask about workouts, exercises, fitness...',
            onSendMessage: _viewModel.sendMessage,
            isLoading: false,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int position) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Opacity(
            opacity: (value - (0.2 * position) + 0.6) % 1.0,
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 4,
              ),
            ),
          ),
        );
      },
    );
  }
}
