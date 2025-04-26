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

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);

    if (_viewModel.messages.isEmpty) {
      _viewModel.addMessage(
        ChatMessage(
          text:
              'Hi there! Iam your workout assistant. Tell me about your fitness goals, and I will help you build a personalized workout plan!',
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
    setState(() {});
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Image.asset(AssetsData.first),
        ),
        Expanded(
          child: _viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  itemCount: _viewModel.messages.length,
                  itemBuilder: (context, index) {
                    final message = _viewModel.messages[index];
                    return ChatMessageBubble(
                      message: message,
                      showAvatar: !message.isUser,
                    );
                  },
                ),
        ),
        ChatInputField(
          hintText: 'Ask about workouts, exercises, fitness...',
          onSendMessage: _viewModel.sendMessage,
          isLoading: _viewModel.isLoading,
        ),
      ],
    );
  }
}
