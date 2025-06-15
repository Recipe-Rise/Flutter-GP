import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/features/chat/presentation/widgets/workouts_chat_tap.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/reciepes_chat_tap.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = ['Recipes', 'Workouts'];
  int _selectedCategory = 0;
  int _selectedIndex = 2; // Default to Chatbot tab (index 2)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategory = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'AI Assistant',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kButtonColor),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color.fromARGB(255, 209, 193, 214),
          //     Color.fromARGB(255, 143, 170, 205),
          //     Colors.white,
          //   ],
          //   stops: [0.0, 0.2, 0.2],
          // ),
        ),
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _categories.map((category) {
                  int index = _categories.indexOf(category);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      onPressed: () => _onCategorySelected(index),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: _selectedCategory == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: _selectedCategory == index
                              ? Color(0xff27547F)
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  RecipesChatTab(),
                  WorkoutsChatTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: const Color(0xFF1A75FF),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index != _selectedIndex) {
            AppNavigator.navigateToTabScreen(context, index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.dumbbell),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.message),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.utensils),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}