import 'package:fitfork_gp/features/chat/data/models/chat_message.dart';
import 'package:flutter/foundation.dart';
import 'package:fitfork_gp/core/services/gemini_service.dart';

abstract class BaseChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final GeminiService geminiService = GeminiService();

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    addMessage(userMessage);

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final response = await getAIResponse(text);

      final aiMessage = ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      addMessage(aiMessage);
    } catch (e) {
      final errorMessage = ChatMessage(
        text: 'Sorry, I encountered an error. Please try again.',
        isUser: false,
        timestamp: DateTime.now(),
      );
      addMessage(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> getAIResponse(String userMessage);
}
