import 'package:fitfork_gp/features/WorkOuts/presentation/cubit/cubit.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/cubit/states.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/views/each_bodyPart_workouts.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/views/workout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animations/animations.dart'; // for transitions
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/styles.dart';

class FullBodyWorkout extends StatelessWidget {
  const FullBodyWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) {
            AppNavigator.navigateToTabScreen(context, index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.dumbbell), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.message), label: 'Chatbot'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.utensils), label: 'Recipes'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user), label: 'Profile'),
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
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                icon: Icons.chevron_left,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  //   _createRoute(const WorkoutsScreen()),
                  // );
                },
              ),
              const Spacer(),
              Text('Full Body Workout',
                  style: Styles.textStyle22.copyWith(
                      fontWeight: FontWeight.bold ,
                    color: Colors.white,
                  )),
              const Spacer(),
              // CustomIconButton(icon: Icons.more_horiz, onPressed: () {}),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Center(
            child: Hero(
              tag: 'full_body_image',
              child: SvgPicture.asset(
                AssetsData.full_body,
                height: size.height * 0.25,
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

class CurvedContainerSection extends StatelessWidget {
  const CurvedContainerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkOutCubit.get(context).getBodyParts();
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: size.width * 0.15,
                      height: size.height * 0.005,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(size.height * 0.01),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Target Body Parts',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Expanded(
                    child: BlocConsumer<WorkOutCubit, WorkOutsStates>(
                      listener: (context, state) {
                        if (state is WorkOutsBodyPartsErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is WorkOutBodyPartsSuccessState) {
                          final bodyParts = state.bodyParts;
                          return ListView.builder(
                            itemCount: bodyParts.length,
                            itemBuilder: (context, index) {
                              final bodyPart = bodyParts[index];
                              final imageUrl = 'assets/images/$bodyPart.png';
                              return OpenContainer(
                                transitionType: ContainerTransitionType.fadeThrough,
                                closedElevation: 0,
                                closedColor: Colors.transparent,
                                openColor: Colors.white,
                                closedBuilder: (context, action) => BodyPartCard(
                                  name: bodyPart,
                                  imageUrl: imageUrl,
                                  onArrowPressed: action,
                                ),
                                openBuilder: (context, action) => EachBodypartWorkouts(bodyPart: bodyPart),
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator(color: Color(0xff4597ff)));
                      },
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

class BodyPartCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onArrowPressed;

  const BodyPartCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.onArrowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onArrowPressed,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl,
                    width: size.width * 0.2,
                    height: size.width * 0.2,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                ),
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff4597ff),
        borderRadius: BorderRadius.circular(size.width * 0.02),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: size.width * 0.06),
        onPressed: onPressed,
        padding: EdgeInsets.all(size.width * 0.02),
        constraints: const BoxConstraints(),
      ),
    );
  }
}

// Helper: fade-through transition
Route _createRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
