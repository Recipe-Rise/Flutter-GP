import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static late SharedPreferences sharedPreferences;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String? key,
}){
    return sharedPreferences.get(key!);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
}) async {

    if(value is String){
      return await sharedPreferences.setString(key, value);
    }
    if(value is int){
      return await sharedPreferences.setInt(key, value);
    }
    if(value is bool){
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setDouble(key, value);

  }

  static Future<bool> removeData({
    required String key,
}) async
  {
    return await sharedPreferences.remove(key);
  }

  Future<void> saveConsumedCalories(double consumedCalories) async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayKey();
    await prefs.setDouble('consumed_calories_$today', consumedCalories);
    await prefs.setInt('last_calorie_update', DateTime.now().millisecondsSinceEpoch);
  }

  // Get consumed calories for today
  Future<double> getConsumedCalories() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayKey();
    return prefs.getDouble('consumed_calories_$today') ?? 0.0;
  }

  // Add calories to today's consumption
  Future<void> addConsumedCalories(double calories) async {
    final currentConsumed = await getConsumedCalories();
    await saveConsumedCalories(currentConsumed + calories);
  }

  // Get remaining calories (BMR - consumed)
  Future<double> getRemainingCalories(double bmr) async {
    final consumedCalories = await getConsumedCalories();
    final remaining = (bmr - consumedCalories).clamp(0.0, bmr);
    return remaining;
  }

  // Reset calories for a new day (this should be called when day changes)
  Future<void> resetDailyCalories() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayKey();
    await prefs.remove('consumed_calories_$today');
  }

  // Check if we need to reset calories for a new day
  Future<bool> shouldResetCalories() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdate = prefs.getInt('last_calorie_update') ?? 0;
    final lastUpdateDate = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
    final today = DateTime.now();

    // Check if the last update was on a different day
    return lastUpdateDate.day != today.day ||
        lastUpdateDate.month != today.month ||
        lastUpdateDate.year != today.year;
  }

  // Get today's date as a string key
  String _getTodayKey() {
    final now = DateTime.now();
    return '${now.year}_${now.month}_${now.day}';
  }

  // Get calorie data for the day
  Future<Map<String, double>> getCalorieData(double bmr) async {
    // Check if we need to reset for a new day
    if (await shouldResetCalories()) {
      await resetDailyCalories();
    }

    final consumed = await getConsumedCalories();
    final remaining = await getRemainingCalories(bmr);

    return {
      'consumed': consumed,
      'remaining': remaining,
      'bmr': bmr,
      'completionPercentage': bmr > 0 ? (consumed / bmr).clamp(0.0, 1.0) : 0.0,
    };
  }
}