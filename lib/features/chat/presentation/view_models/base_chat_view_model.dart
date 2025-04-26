import 'package:fitfork_gp/features/chat/data/models/chat_message.dart';
import 'package:flutter/foundation.dart';
import 'package:fitfork_gp/core/services/gemini_service.dart';

abstract class BaseChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  // Make geminiService protected (accessible to subclasses) by removing the underscore
  final GeminiService geminiService = GeminiService();

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    addMessage(userMessage);

    // Set loading state
    _isLoading = true;
    notifyListeners();

    try {
      // Get AI response
      final response = await getAIResponse(text);

      // Add AI message
      final aiMessage = ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      addMessage(aiMessage);
    } catch (e) {
      // Handle error
      final errorMessage = ChatMessage(
        text: 'Sorry, I encountered an error. Please try again.',
        isUser: false,
        timestamp: DateTime.now(),
      );
      addMessage(errorMessage);
    } finally {
      // Reset loading state
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> getAIResponse(String userMessage);
}
