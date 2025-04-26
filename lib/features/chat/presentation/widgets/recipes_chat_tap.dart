import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/features/chat/data/models/chat_message.dart';
import 'package:fitfork_gp/features/chat/presentation/view_models/recipe_chat_view_model.dart';
import 'package:fitfork_gp/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:fitfork_gp/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class RecipesChatTab extends StatefulWidget {
  const RecipesChatTab({super.key});

  @override
  State<RecipesChatTab> createState() => _RecipesChatTabState();
}

class _RecipesChatTabState extends State<RecipesChatTab> {
  final RecipeChatViewModel _viewModel = RecipeChatViewModel();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);

    if (_viewModel.messages.isEmpty) {
      _viewModel.addMessage(
        ChatMessage(
          text:
              'Hello! I am your recipe assistant. Tell me your dietary preferences, and I will help you find delicious recipes that match your needs!',
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: Image.asset(
            AssetsData.pan,
            width: 200,
          ),
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
          hintText: 'Ask about recipes, diets, nutrition...',
          onSendMessage: _viewModel.sendMessage,
          isLoading: _viewModel.isLoading,
        ),
      ],
    );
  }
}
