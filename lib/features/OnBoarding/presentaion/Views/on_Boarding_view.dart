import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/features/OnBoarding/data/models/onboarding_item.dart';
import 'package:fitfork_gp/features/OnBoarding/presentaion/Views/widgets/onboarding_indicator.dart';
import 'package:fitfork_gp/features/OnBoarding/presentaion/Views/widgets/onboarding_page.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: "Track Your Goal",
      descreption:
          "Do not worry if you have trouble determining your goals. We can help you determine your goals and track your goals.",
      imagePath: AssetsData.track,
    ),
    OnboardingItem(
      title: "Get Burn",
      descreption:
          "Keep burning, to achieve your goals, it hurts only temporarily. If you give up now you will be in pain forever.",
      imagePath: AssetsData.gett,
    ),
    OnboardingItem(
      title: "Eat Well",
      descreption:
          " Start a healthy lifestyle with us, we can determine your diet every day. Facility eating is fun.",
      imagePath: AssetsData.eat,
    ),
    OnboardingItem(
      title: "Improve Sleep Quality",
      descreption:
          "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning.",
      imagePath: "assets/images/improve.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingItems.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPage(
                  item: _onboardingItems[index],
                );
              },
            ),
          ),
          OnboardingIndicator(
            currentPage: _currentPage,
            pageCount: _onboardingItems.length,
          ),
          _buildArrowButton(),
        ],
      ),
    );
  }

  Widget _buildArrowButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            if (_currentPage < _onboardingItems.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen1(),
                ),
              );
            }
          },
          child: Image.asset(
            AssetsData.arrow,
            width: 60,
            height: 60,
          ),
        ),
      ),
    );
  }
}
