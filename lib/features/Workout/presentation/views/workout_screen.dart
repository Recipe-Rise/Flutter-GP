import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFF4da0ff),
              Color(0xFF2e8cff),
            ],
          ),
        ),
        child: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),
              CurvedContainerSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: const Color(0xFF1A75FF),
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Workouts tab is index 1
        onTap: (index) {
          if (index != 1) {
            // Only navigate if not already on Workouts tab
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

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.04,
        size.height * 0.02,
        size.width * 0.04,
        0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                icon: Icons.chevron_left,
                onPressed: () {},
              ),
              Text('Workout Tracker',
                  style:
                      Styles.textStyle22.copyWith(fontWeight: FontWeight.bold)),
              CustomIconButton(
                icon: Icons.more_horiz,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: size.height * 0.020),
          Center(
            child: Image.asset(
              AssetsData.first,
              height: size.height * 0.2,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: size.height * 0.025,
          )
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.02),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: size.width * 0.06),
        onPressed: onPressed,
        padding: EdgeInsets.all(size.width * 0.02),
        constraints: const BoxConstraints(),
      ),
    );
  }
}

class CurvedContainerSection extends StatelessWidget {
  const CurvedContainerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * 0.08),
                topRight: Radius.circular(size.width * 0.08),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'What Do You Want to Train',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Expanded(
                    child: ListView(
                      children: [
                        WorkoutCard(
                          title: 'Fullbody Workout',
                          exercises: 11,
                          duration: 32,
                          imagePath: AssetsData.full,
                        ),
                        SizedBox(height: size.height * 0.03),
                        WorkoutCard(
                          title: 'Lowerbody Workout',
                          exercises: 12,
                          duration: 40,
                          imagePath: AssetsData.low,
                        ),
                        SizedBox(height: size.height * 0.03),
                        WorkoutCard(
                          title: 'AB Workout',
                          exercises: 14,
                          duration: 20,
                          imagePath: AssetsData.ab,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.01,
            child: Container(
              width: size.width * 0.15,
              height: size.height * 0.005,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(size.height * 0.01),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final String title;
  final int exercises;
  final int duration;
  final String imagePath;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.exercises,
    required this.duration,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.16,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FE),
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    '$exercises Exercises | ${duration}mins',
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  const ViewMoreButton(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size.width * 0.12),
              ),
              margin: EdgeInsets.all(size.width * 0.03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.025,
        vertical: size.height * 0.010,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Text('View more',
          style: Styles.textStyle14.copyWith(color: Colors.blue)),
    );
  }
}
