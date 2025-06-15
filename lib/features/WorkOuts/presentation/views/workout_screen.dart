import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Home/presentation/views/home_screen.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/views/ab_workout.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/views/upper_body_workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'full_bodey_workout.dart';
import 'lower_body_workout.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _contentAnimationController;
  late Animation<double> _headerSlideAnimation;
  late Animation<double> _headerFadeAnimation;
  late Animation<double> _contentSlideAnimation;
  late Animation<double> _contentFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Header animations
    _headerSlideAnimation = Tween<double>(
      begin: -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOut,
    ));

    // Content animations
    _contentSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _contentFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.easeOut,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await _headerAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _contentAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _contentAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4da0ff),
              Color(0xFF2e8cff),
              Color(0xFF1e7ae4),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                floating: true,
                snap: true,
                pinned: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF4da0ff),
                          Color(0xFF2e8cff),
                          Color(0xFF1e7ae4),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: SafeArea(
                      child: AnimatedBuilder(
                        animation: _headerAnimationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _headerSlideAnimation.value),
                            child: Opacity(
                              opacity: _headerFadeAnimation.value,
                              child: const HeaderSection(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: AnimatedBuilder(
            animation: _contentAnimationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _contentSlideAnimation.value),
                child: Opacity(
                  opacity: _contentFadeAnimation.value,
                  child: const CurvedContainerSection(),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: const Color(0xFF1A75FF),
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) {
            HapticFeedback.lightImpact();
            AppNavigator.navigateToTabScreen(context, index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomIconButton(
              //   icon: Icons.chevron_left_rounded,
              //   onPressed: () {
              //     // HapticFeedback.lightImpact();
              //     // Navigator.pop(context);
              //   },
              // ),
              Hero(
                tag: 'workout_title',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'Workout Tracker',
                    style: Styles.textStyle22.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              // CustomIconButton(
              //   icon: Icons.more_horiz_rounded,
              //   onPressed: () {
              //     // HapticFeedback.lightImpact();
              //   },
              // ),
            ],
          ),
          SizedBox(height: size.height * 0.025),
          Hero(
            tag: 'workout_illustration',
            child: Container(
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(size.width * 0.06),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: SvgPicture.asset(
                AssetsData.main_workout,
                height: size.height * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.025),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) => _animationController.reverse(),
            onTapCancel: () => _animationController.reverse(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(size.width * 0.03),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: size.width * 0.06,
                ),
                onPressed: widget.onPressed,
                padding: EdgeInsets.all(size.width * 0.02),
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CurvedContainerSection extends StatelessWidget {
  const CurvedContainerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.width * 0.08),
          topRight: Radius.circular(size.width * 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top handle indicator
          Container(
            margin: EdgeInsets.only(top: size.height * 0.015),
            width: size.width * 0.12,
            height: size.height * 0.004,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(size.height * 0.01),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'What Do You Want to Train?',
                    style: TextStyle(
                      fontSize: size.width * 0.055,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AnimatedWorkoutCard(
                          title: 'Full Body Workout',
                          exercises: 11,
                          duration: 32,
                          imagePath: AssetsData.full,
                          targetScreen: const FullBodyWorkout(),
                          delay: const Duration(milliseconds: 100),
                        ),
                        SizedBox(height: size.height * 0.02),
                        AnimatedWorkoutCard(
                          title: 'Upper Body Workout',
                          exercises: 10,
                          duration: 30,
                          imagePath: AssetsData.reg2,
                          targetScreen: const UpperBodyWorkout(),
                          delay: const Duration(milliseconds: 200),
                        ),
                        SizedBox(height: size.height * 0.02),
                        AnimatedWorkoutCard(
                          title: 'Lower Body Workout',
                          exercises: 12,
                          duration: 40,
                          imagePath: AssetsData.low,
                          targetScreen: const LowerBodyWorkout(),
                          delay: const Duration(milliseconds: 300),
                        ),
                        SizedBox(height: size.height * 0.02),
                        AnimatedWorkoutCard(
                          title: 'AB Workout',
                          exercises: 14,
                          duration: 20,
                          imagePath: AssetsData.ab,
                          targetScreen: AbWorkout(),
                          delay: const Duration(milliseconds: 400),
                        ),
                        SizedBox(height: size.height * 0.05),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class AnimatedWorkoutCard extends StatefulWidget {
  final String title;
  final int exercises;
  final int duration;
  final String imagePath;
  final Widget targetScreen;
  final Duration delay;

  const AnimatedWorkoutCard({
    super.key,
    required this.title,
    required this.exercises,
    required this.duration,
    required this.imagePath,
    required this.targetScreen,
    required this.delay,
  });

  @override
  State<AnimatedWorkoutCard> createState() => _AnimatedWorkoutCardState();
}

class _AnimatedWorkoutCardState extends State<AnimatedWorkoutCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _pressController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _pressController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _pressController,
      curve: Curves.easeInOut,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: GestureDetector(
                onTapDown: (_) {
                  HapticFeedback.selectionClick();
                  _pressController.forward();
                },
                onTapUp: (_) => _pressController.reverse(),
                onTapCancel: () => _pressController.reverse(),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      widget.targetScreen,
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutCubic;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 400),
                    ),
                  );
                },
                child: Container(
                  constraints: BoxConstraints(minHeight: size.height * 0.16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.grey.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(size.width * 0.05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.shade800,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.008),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.fitness_center_rounded,
                                      size: size.width * 0.035,
                                      color: Colors.grey.shade600,
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Text(
                                      '${widget.exercises} Exercises',
                                      style: TextStyle(
                                        fontSize: size.width * 0.032,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.03),
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: size.width * 0.035,
                                      color: Colors.grey.shade600,
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Text(
                                      '${widget.duration}min',
                                      style: TextStyle(
                                        fontSize: size.width * 0.032,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.012),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.035,
                                        vertical: size.height * 0.007,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF4da0ff),
                                            Color(0xFF2e8cff),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(size.width * 0.04),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF2e8cff).withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Start Workout',
                                            style: TextStyle(
                                              fontSize: size.width * 0.03,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.01),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: size.width * 0.032,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.all(size.width * 0.025),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFF),
                              borderRadius: BorderRadius.circular(size.width * 0.04),
                              border: Border.all(
                                color: const Color(0xFF4da0ff).withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(size.width * 0.04),
                              child: Image.asset(
                                widget.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

