import 'package:fitfork_gp/features/chat/presentation/view_models/base_chat_view_model.dart';

class RecipeChatViewModel extends BaseChatViewModel {
  @override
  Future<String> getAIResponse(String userMessage) async {
    // Now we can access geminiService without the underscore
    return await geminiService.getRecipeRecommendations(userMessage);
  }
}