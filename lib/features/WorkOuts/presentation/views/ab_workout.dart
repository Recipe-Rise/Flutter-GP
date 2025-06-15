import 'package:fitfork_gp/features/WorkOuts/presentation/views/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/styles.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'each_bodyPart_workouts.dart';

class AbWorkout extends StatelessWidget {
  const AbWorkout({super.key});

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
                onPressed: () {

                  Navigator.of(context).pop();


                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const WorkoutsScreen(),
                  //   ),
                  // );
                },
              ),
              const Spacer(),
              Text('Ab Workout',
                  style:
                  Styles.textStyle22.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  )),
              // CustomIconButton(
              //   icon: FontAwesomeIcons.ellipsisVertical,
              //   onPressed: () {},
              // ),
              const Spacer(),
            ],
          ),
          SizedBox(height: size.height * 0.020),
          Center(
            child: Image.asset(
              AssetsData.ab,
              height: size.height * 0.25,
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
        color: Color(0xff4597ff),
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

    return Card(
      color: Colors.white,
      elevation: 1.75,
      margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrl,
                width: size.width * 0.21,
                height: size.width * 0.21,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),

            SizedBox(width: size.width * 0.04,),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onPressed: onArrowPressed,
            ),

          ],
        ),
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
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Ab Workout',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Expanded(
                    child : BlocConsumer<WorkOutCubit , WorkOutsStates> (
                      listener: (context , state) {
                        if (state is WorkOutsBodyPartsErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context , state){

                        if(state is WorkOutBodyPartsSuccessState){
                          final bodyParts = state.bodyParts
                              .where((bodyPart) => bodyPart.toLowerCase() == 'cardio' || bodyPart.toLowerCase() == 'waist').toList();
                          return ListView.builder(
                            itemCount: bodyParts.length,
                            itemBuilder: (context, index) {
                              final bodyPart = bodyParts[index];
                              final imageUrl = 'assets/images/${bodyPart.toLowerCase()}.png';
                                return BodyPartCard(
                                  name: bodyPart,
                                  imageUrl: imageUrl,
                                  onArrowPressed: (){
                                    if(bodyPart == 'cardio'){
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const EachBodypartWorkouts(bodyPart: 'cardio');
                                          },
                                        ),
                                      );
                                    }
                                    else if(bodyPart == 'waist'){
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const EachBodypartWorkouts(bodyPart: 'waist');
                                          },
                                        ),
                                      );
                                    }
                                  },
                                );

                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator( color: Color(0xff4597ff),));

                      },

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

