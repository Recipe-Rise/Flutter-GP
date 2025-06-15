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
import '../widgets/curved_container_section.dart';
import '../widgets/header_section.dart';
import 'each_bodyPart_workouts.dart';

class UpperBodyWorkout extends StatelessWidget {
  const UpperBodyWorkout({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text('Upper Body Workout',
                  style:
                  Styles.textStyle22.copyWith(
                      fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              const Spacer(),

            ],
          ),
          SizedBox(height: size.height * 0.020),
          Center(
            child: Image.asset(
              AssetsData.reg2,
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
                    'Upper Body Workout',
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
                              .where((bodyPart) => bodyPart.toLowerCase() == 'upper arms' ||
                              bodyPart.toLowerCase() == 'shoulders' ||
                              bodyPart.toLowerCase() == 'neck' ||
                              bodyPart.toLowerCase() == 'lower arms' ||
                              bodyPart.toLowerCase() == 'back' ||
                              bodyPart.toLowerCase() == 'chest').toList();

                          return ListView.builder(
                            itemCount: bodyParts.length,
                            itemBuilder: (context, index) {
                              final bodyPart = bodyParts[index];
                              final imageUrl ='assets/images/$bodyPart.png';
                              return BodyPartCard(
                                name: bodyPart,
                                imageUrl: imageUrl,
                                onArrowPressed: (){
                                  if(bodyPart == 'lower arms'){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const EachBodypartWorkouts(bodyPart: 'lower arms',),
                                      ),
                                    );
                                  }
                                  else if(bodyPart == 'upper arms'){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const EachBodypartWorkouts(bodyPart: 'upper arms',),
                                      ),
                                    );
                                  }
                                  else if(bodyPart == 'neck'){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const EachBodypartWorkouts(bodyPart: 'neck',),
                                      ),
                                    );
                                  }
                                  else if(bodyPart == 'shoulders'){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const EachBodypartWorkouts(bodyPart: 'shoulders',),
                                      ),
                                    );
                                  }
                                  else if(bodyPart == 'back'){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const EachBodypartWorkouts(bodyPart: 'back',),
                                      ),
                                    );
                                  }
                                  else if(bodyPart == 'chest'){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const EachBodypartWorkouts(bodyPart: 'chest',),
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




// import 'package:fitfork_gp/features/WorkOuts/presentation/views/workout_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:animations/animations.dart'; // Smooth transitions
// import '../../../../core/utils/app_navigator.dart';
// import '../../../../core/utils/assets.dart';
// import '../../../../core/utils/styles.dart';
// import '../cubit/cubit.dart';
// import '../cubit/states.dart';
// import 'each_bodyPart_workouts.dart';
//
// class UpperBodyWorkout extends StatelessWidget {
//   const UpperBodyWorkout({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: const UpperBodyWorkoutBody(),
//       bottomNavigationBar: _buildBottomNavBar(context),
//     );
//   }
//
//   Widget _buildBottomNavBar(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: Colors.white,
//       elevation: 10,
//       selectedItemColor: const Color(0xFF1A75FF),
//       unselectedItemColor: Colors.grey,
//       currentIndex: 1,
//       onTap: (index) {
//         if (index != 1) {
//           AppNavigator.navigateToTabScreen(context, index);
//         }
//       },
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.dumbbell),
//           label: 'Workouts',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.message),
//           label: 'Chatbot',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.utensils),
//           label: 'Recipes',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.user),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
//
// class UpperBodyWorkoutBody extends StatelessWidget {
//   const UpperBodyWorkoutBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.center,
//           colors: [Color(0xFF4da0ff), Color(0xFF2e8cff)],
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _HeaderSection(size: size),
//             const Expanded(child: CurvedContainerSection()),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HeaderSection extends StatelessWidget {
//   final Size size;
//
//   const _HeaderSection({required this.size});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.02),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               _CustomIconButton(
//                 icon: Icons.chevron_left,
//                 onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WorkoutsScreen())),
//               ),
//               const Spacer(),
//               Text('Upper Body Workout', style: Styles.textStyle22.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
//               const Spacer(),
//               _CustomIconButton(icon: Icons.more_horiz, onPressed: () {}),
//             ],
//           ),
//           SizedBox(height: size.height * 0.02),
//           Center(
//             child: Hero(
//               tag: 'workoutImage',
//               child: Image.asset(AssetsData.reg2, height: size.height * 0.25, fit: BoxFit.contain),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _CustomIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onPressed;
//
//   const _CustomIconButton({required this.icon, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: IconButton(
//         icon: Icon(icon, color: Colors.white, size: size.width * 0.06),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }
//
// class CurvedContainerSection extends StatelessWidget {
//   const CurvedContainerSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     WorkOutCubit.get(context).getBodyParts();
//     final size = MediaQuery.of(context).size;
//
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeOut,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(size.width * 0.08)),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(size.width * 0.05),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Container(
//                     width: size.width * 0.15,
//                     height: size.height * 0.005,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(size.height * 0.01),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.02),
//                 Text('Upper Body Workout', style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold)),
//                 SizedBox(height: size.height * 0.02),
//                 Expanded(
//                   child: BlocConsumer<WorkOutCubit, WorkOutsStates>(
//                     listener: (context, state) {
//                       if (state is WorkOutsBodyPartsErrorState) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is WorkOutBodyPartsSuccessState) {
//                         final upperBodyParts = state.bodyParts.where((part) =>
//                             ['upper arms', 'shoulders', 'neck', 'lower arms', 'back', 'chest'].contains(part.toLowerCase())
//                         ).toList();
//
//                         return ListView.builder(
//                           itemCount: upperBodyParts.length,
//                           itemBuilder: (context, index) {
//                             final bodyPart = upperBodyParts[index];
//                             final imageUrl = 'assets/images/$bodyPart.png';
//                             return OpenContainer(
//                               transitionDuration: const Duration(milliseconds: 500),
//                               openBuilder: (context, _) => EachBodypartWorkouts(bodyPart: bodyPart),
//                               closedElevation: 0,
//                               closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               closedBuilder: (context, openContainer) => _BodyPartCard(
//                                 name: bodyPart,
//                                 imageUrl: imageUrl,
//                                 onTap: openContainer,
//                               ),
//                             );
//                           },
//                         );
//                       }
//                       return const Center(child: CircularProgressIndicator(color: Color(0xff4597ff)));
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _BodyPartCard extends StatelessWidget {
//   final String name;
//   final String imageUrl;
//   final VoidCallback onTap;
//
//   const _BodyPartCard({
//     required this.name,
//     required this.imageUrl,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return FadeIn(
//       delay: const Duration(milliseconds: 100),
//       child: Card(
//         elevation: 3,
//         margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: ListTile(
//           leading: ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.asset(imageUrl, width: size.width * 0.15, height: size.width * 0.15, fit: BoxFit.cover),
//           ),
//           title: Text(name, style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500)),
//           trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//           onTap: onTap,
//         ),
//       ),
//     );
//   }
// }
//
// class FadeIn extends StatefulWidget {
//   final Widget child;
//   final Duration delay;
//
//   const FadeIn({required this.child, this.delay = Duration.zero, super.key});
//
//   @override
//   State<FadeIn> createState() => _FadeInState();
// }
//
// class _FadeInState extends State<FadeIn> {
//   bool _visible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(widget.delay, () {
//       if (mounted) setState(() => _visible = true);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0, end: _visible ? 1 : 0),
//       duration: const Duration(milliseconds: 500),
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - value)),
//             child: child,
//           ),
//         );
//       },
//       child: widget.child,
//     );
//   }
// }

