// // import 'package:fitfork_gp/constants.dart';
// // import 'package:fitfork_gp/core/utils/app_navigator.dart';
// // import 'package:fitfork_gp/core/utils/styles.dart';
// // import 'package:fitfork_gp/features/Home/presentation/widgets/activity_status_header.dart';
// // import 'package:fitfork_gp/features/Home/presentation/widgets/bmi_card.dart';
// // import 'package:fitfork_gp/features/Home/presentation/widgets/calories_card.dart';
// // import 'package:fitfork_gp/features/Home/presentation/widgets/sleep_card.dart';
// // import 'package:fitfork_gp/features/Home/presentation/widgets/water_intake_card.dart';
// // import 'package:fitfork_gp/shared/cubit/appCubit.dart';
// // import 'package:fitfork_gp/shared/cubit/appCubitStates.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:fitfork_gp/features/Home/presentation/views/calories_tracking_screen.dart';
// // import 'package:fitfork_gp/features/Home/presentation/views/sleep_insights_screen.dart';
// // import 'package:fitfork_gp/features/Home/presentation/views/water_intake_screen.dart';
// //
// // import '../../../../constants.dart';
// // import '../../../../constants.dart';
// // import '../../../../shared/network/local/cache_helper.dart';
// // import '../../../Step_counter/step_counter_widget.dart';
// //
// //
// // class HomeScreen extends StatefulWidget {
// //   final String firstName;
// //
// //   const HomeScreen({
// //     super.key,
// //     required this.firstName,
// //   });
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   int _selectedIndex = 0;
// //
// //   double savedRemainingCalories = 0.0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadRemainingCalories();
// //   }
// //
// //   Future<void> _loadRemainingCalories() async {
// //     final bmr = double.tryParse(AppCubit.get(context).getUserData?.bmr ?? '0.0') ?? 0.0;
// //     savedRemainingCalories = await CacheHelper().getRemainingCalories(bmr) ?? bmr;
// //     setState(() {
// //       savedRemainingCalories = savedRemainingCalories;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context)  {
// //     final waterIntakeUpdates = [
// //       {"time": "6am - 8am", "amount": "600"},
// //       {"time": "9am - 11am", "amount": "500"},
// //       {"time": "11am - 2pm", "amount": "1000"},
// //       {"time": "2pm - 4pm", "amount": "700"},
// //       {"time": "4pm - now", "amount": "900"},
// //     ];
// //
// //     final bmr = double.parse(AppCubit.get(context).getUserData?.bmr ?? '0.0');
// //
// //
// //
// //
// //     int totalWaterIntake = 0;
// //     for (var update in waterIntakeUpdates) {
// //       totalWaterIntake += int.parse(update["amount"]!);
// //     }
// //
// //     return BlocConsumer<AppCubit , AppStates>(
// //       listener: (context , state){},
// //       builder: (context,state){
// //           return Scaffold(
// //             body: SafeArea(
// //               child: SingleChildScrollView(
// //                 padding: const EdgeInsets.symmetric(
// //                     horizontal: 24, vertical: 16),
// //         child: state is AppLoadingUserDataState ? const
// //         Center(child: CircularProgressIndicator(color: Colors.blue,))
// //
// //
// //                 : Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           "Welcome Back,",
// //                           style: Styles.textStyle16.copyWith(
// //                             color: Colors.black.withOpacity(0.6),
// //                           ),
// //                         ),
// //                         // const Icon(
// //                         //   FontAwesomeIcons.bell,
// //                         //   size: 18,
// //                         // ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 12),
// //                     Text(
// //                       AppCubit
// //                           .get(context)
// //                           .getUserData!
// //                           .name!,
// //                       style: Styles.textStyle26,
// //                     ),
// //                     const SizedBox(height: 16),
// //                     BmiCard(bmi: double.tryParse(AppCubit
// //                         .get(context)
// //                         .getUserData
// //                         ?.bmi ?? '') ?? 0.0,),
// //                     const SizedBox(height: 24),
// //                     const ActivityStatusHeader(),
// //                     const SizedBox(height: 16),
// //                     IntrinsicHeight(
// //                       child: Row(
// //                         crossAxisAlignment: CrossAxisAlignment.stretch,
// //                         children: [
// //                           Expanded(
// //                             flex: 1,
// //                             child: WaterIntakeCard(
// //                               onTap: () {
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                     builder: (context) => WaterIntakeScreen(),
// //                                   ),
// //                                 );
// //                               },
// //                               waterIntakeInML: totalWaterIntake,
// //                               timeUpdates: waterIntakeUpdates,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 16),
// //                           Expanded(
// //                             flex: 1,
// //                             child: Column(
// //                               mainAxisSize: MainAxisSize.min,
// //                               children: [
// //                                 SleepCard(
// //                                   hours: "8",
// //                                   minutes: "20",
// //                                   onTap: () {
// //                                     Navigator.push(
// //                                       context,
// //                                       MaterialPageRoute(
// //                                           builder: (context) =>
// //                                               SleepInsightsScreen()),
// //                                     );
// //                                   },
// //                                 ),
// //                                 const SizedBox(height: 16),
// //                                 CaloriesCard(
// //
// //                                   onTap: () //async
// //                                   {
// //                                     // final double remaining = await CacheHelper().getRemainingCalories(double.tryParse(AppCubit
// //                                     //     .get(context)
// //                                     //     .getUserData
// //                                     //     ?.bmr ?? '') ?? 0.0,) ?? 0.0;
// //                                     //
// //                                     // Navigator.push(
// //                                     //   context,
// //                                     //   MaterialPageRoute(
// //                                     //       builder: (context)=>
// //                                     //           CaloriesTrackingScreen(
// //                                     //             bmr:double.tryParse(AppCubit.get(context).getUserData?.bmr ?? '') ?? 0.0,
// //                                     //             consumedCalories: double.tryParse(AppCubit.get(context).getUserData?.bmr ?? '') ?? 0.0 - remaining,
// //                                     //             remainingCalories: remaining ,
// //                                     //
// //                                     //           )),
// //                                     //
// //                                     // );
// //                                   },
// //                                   bmr: bmr,
// //                                   consumedCalories: (bmr - savedRemainingCalories).clamp(0.0, bmr),
// //                                   //double.tryParse(AppCubit.get(context).getUserData!.bmr!) ?? 0.0 - savedRemainingCalories,
// //                                 ),
// //                                 const SizedBox(height: 16),
// //                                 const StepCounterWidget(),
// //                                 const SizedBox(height: 20),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             bottomNavigationBar: BottomNavigationBar(
// //               type: BottomNavigationBarType.fixed,
// //               backgroundColor: Colors.white,
// //               elevation: 8,
// //               selectedItemColor: const Color(0xFF1A75FF),
// //               unselectedItemColor: Colors.grey,
// //               currentIndex: _selectedIndex,
// //               onTap: (index) {
// //                 if (index != _selectedIndex) {
// //                   final args = {
// //                     'firstName': AppCubit
// //                         .get(context)
// //                         .getUserData!
// //                         .name!,
// //                     'bmi': double.tryParse(AppCubit
// //                         .get(context)
// //                         .getUserData
// //                         ?.bmi ?? '') ?? 0.0,
// //                     'bmr': double.tryParse(AppCubit
// //                         .get(context)
// //                         .getUserData
// //                         ?.bmr ?? '') ?? 0.0,
// //                   };
// //                   AppNavigator.navigateToTabScreen(
// //                       context, index, arguments: args);
// //                 } else {
// //                   setState(() {
// //                     _selectedIndex = index;
// //                   });
// //                 }
// //               },
// //               items: const [
// //                 BottomNavigationBarItem(
// //                   icon: Icon(Icons.home),
// //                   label: 'Home',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(FontAwesomeIcons.dumbbell),
// //                   label: 'Workouts',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(FontAwesomeIcons.message),
// //                   label: 'Chatbot',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(FontAwesomeIcons.utensils),
// //                   label: 'Recipes',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(FontAwesomeIcons.user),
// //                   label: 'Profile',
// //                 ),
// //               ],
// //             ),
// //           );
// //
// //       },
// //     );
// //   }
// // }
//
import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/activity_status_header.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/bmi_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/calories_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/sleep_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/water_intake_card.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:fitfork_gp/shared/cubit/appCubitStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfork_gp/features/Home/presentation/views/calories_tracking_screen.dart';
import 'package:fitfork_gp/features/Home/presentation/views/sleep_insights_screen.dart';
import 'package:fitfork_gp/features/Home/presentation/views/water_intake_screen.dart';

import '../../../../constants.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../Step_counter/step_counter_widget.dart';

class HomeScreen extends StatefulWidget {
  final String firstName;
  final double? bmi;
  final double? bmr;

  const HomeScreen({
    super.key,
    this.firstName = '',
    this.bmi =0.0,
    this.bmr=0.0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final CacheHelper _cacheHelper = CacheHelper();

  @override
  void initState() {
    super.initState();
    _checkAndResetDailyCalories();
  }

  Future<void> _checkAndResetDailyCalories() async {
    // Check if we need to reset calories for a new day
    if (await _cacheHelper.shouldResetCalories()) {
      await _cacheHelper.resetDailyCalories();
      // Trigger a rebuild to show updated data
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final userData = AppCubit.get(context).getUserData;

    final waterIntakeUpdates = [
      {"time": "6am - 8am", "amount": "600"},
      {"time": "9am - 11am", "amount": "500"},
      {"time": "11am - 2pm", "amount": "1000"},
      {"time": "2pm - 4pm", "amount": "700"},
      {"time": "4pm - now", "amount": "900"},
    ];

    final bmr = double.parse(AppCubit.get(context).getUserData?.bmr ?? '0.0');

    int totalWaterIntake = 0;
    for (var update in waterIntakeUpdates) {
      totalWaterIntake += int.parse(update["amount"]!);
    }


    // if (userData == null) {
    //   return Scaffold(
    //     body: Center(
    //       child: Text('User data is not available'),
    //     ),
    //   );
    // }

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: state is AppLoadingUserDataState
                  ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue))
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Welcome Back,",
                        style: Styles.textStyle16.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppCubit.get(context).getUserData?.name ?? 'unknown',
                    style: Styles.textStyle26,
                  ),
                  const SizedBox(height: 16),
                  BmiCard(
                    bmi: double.tryParse(
                        AppCubit.get(context).getUserData?.bmi ?? '') ??
                        0.0,
                  ),
                  const SizedBox(height: 24),
                  const ActivityStatusHeader(),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: WaterIntakeCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WaterIntakeScreen(),
                                ),
                              );
                            },
                            waterIntakeInML: totalWaterIntake,
                            timeUpdates: waterIntakeUpdates,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SleepCard(
                                hours: "8",
                                minutes: "20",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SleepInsightsScreen()),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              CaloriesCard(
                                onTap: () async {
                                  // Get current calorie data
                                  final calorieData = await _cacheHelper.getCalorieData(bmr);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CaloriesTrackingScreen(
                                        bmr: bmr,
                                        consumedCalories: calorieData['consumed']!,
                                        remainingCalories: calorieData['remaining']!,
                                      ),
                                    ),
                                  ).then((_) {
                                    // Refresh the home screen when returning from calorie tracking
                                    setState(() {});
                                  });
                                },
                                bmr: bmr,
                              ),
                              const SizedBox(height: 16),
                              const StepCounterWidget(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
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
            currentIndex: _selectedIndex,
            onTap: (index) {
              if (index != _selectedIndex) {
                final args = {
                  'firstName': AppCubit.get(context).getUserData!.name!,
                  'bmi': double.tryParse(
                      AppCubit.get(context).getUserData?.bmi ?? '') ??
                      0.0,
                  'bmr': double.tryParse(
                      AppCubit.get(context).getUserData?.bmr ?? '') ??
                      0.0,
                };
                AppNavigator.navigateToTabScreen(context, index,
                    arguments: args);
              } else {
                setState(() {
                  _selectedIndex = index;
                });
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
      },
    );
  }
}


// import 'package:fitfork_gp/constants.dart';
// import 'package:fitfork_gp/core/utils/app_navigator.dart';
// import 'package:fitfork_gp/core/utils/styles.dart';
// import 'package:fitfork_gp/features/Home/presentation/widgets/activity_status_header.dart';
// import 'package:fitfork_gp/features/Home/presentation/widgets/bmi_card.dart';
// import 'package:fitfork_gp/features/Home/presentation/widgets/calories_card.dart';
// import 'package:fitfork_gp/features/Home/presentation/widgets/sleep_card.dart';
// import 'package:fitfork_gp/features/Home/presentation/widgets/water_intake_card.dart';
// import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
// import 'package:fitfork_gp/shared/cubit/appCubit.dart';
// import 'package:fitfork_gp/shared/cubit/appCubitStates.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:fitfork_gp/features/Home/presentation/views/calories_tracking_screen.dart';
// import 'package:fitfork_gp/features/Home/presentation/views/sleep_insights_screen.dart';
// import 'package:fitfork_gp/features/Home/presentation/views/water_intake_screen.dart';
//
// import '../../../../constants.dart';
// import '../../../../shared/network/local/cache_helper.dart';
// import '../../../Step_counter/step_counter_widget.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   final String? firstName;
//   final double? bmi;
//   final double? bmr;
//
//   const HomeScreen({
//     super.key,
//     this.firstName,
//     this.bmi,
//     this.bmr,
//   });
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   final CacheHelper _cacheHelper = CacheHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _checkAndResetDailyCalories();
//   }
//
//   Future<void> _checkAndResetDailyCalories() async {
//     if (await _cacheHelper.shouldResetCalories()) {
//       await _cacheHelper.resetDailyCalories();
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }
//
//   // Helper method to get user data safely
//   String _getFirstName() {
//     return widget.firstName ??
//         AppCubit.get(context).getUserData?.name ??
//         RegisterCubit.get(context).registerModel?.name ??
//         'User';
//   }
//
//   double _getBMI() {
//     return widget.bmi ??
//         double.tryParse(AppCubit.get(context).getUserData?.bmi ?? '') ??
//         double.tryParse(RegisterCubit.get(context).registerModel?.bmi ?? '') ??
//         0.0;
//   }
//
//   double _getBMR() {
//     return widget.bmr ??
//         double.tryParse(AppCubit.get(context).getUserData?.bmr ?? '') ??
//         double.tryParse(RegisterCubit.get(context).registerModel?.bmr ?? '') ??
//         0.0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final waterIntakeUpdates = [
//       {"time": "6am - 8am", "amount": "600"},
//       {"time": "9am - 11am", "amount": "500"},
//       {"time": "11am - 2pm", "amount": "1000"},
//       {"time": "2pm - 4pm", "amount": "700"},
//       {"time": "4pm - now", "amount": "900"},
//     ];
//
//     final bmr = _getBMR();
//     final firstName = _getFirstName();
//     final bmi = _getBMI();
//
//     int totalWaterIntake = 0;
//     for (var update in waterIntakeUpdates) {
//       totalWaterIntake += int.parse(update["amount"]!);
//     }
//
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           body: SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               child: state is AppLoadingUserDataState
//                   ? const Center(
//                   child: CircularProgressIndicator(color: Colors.blue))
//                   : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Welcome Back,",
//                         style: Styles.textStyle16.copyWith(
//                           color: Colors.black.withOpacity(0.6),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     firstName,
//                     style: Styles.textStyle26,
//                   ),
//                   const SizedBox(height: 16),
//                   BmiCard(bmi: bmi),
//                   const SizedBox(height: 24),
//                   const ActivityStatusHeader(),
//                   const SizedBox(height: 16),
//                   IntrinsicHeight(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: WaterIntakeCard(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => WaterIntakeScreen(),
//                                 ),
//                               );
//                             },
//                             waterIntakeInML: totalWaterIntake,
//                             timeUpdates: waterIntakeUpdates,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SleepCard(
//                                 hours: "8",
//                                 minutes: "20",
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             SleepInsightsScreen()),
//                                   );
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                               CaloriesCard(
//                                 onTap: () async {
//                                   final calorieData = await _cacheHelper.getCalorieData(bmr);
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => CaloriesTrackingScreen(
//                                         bmr: bmr,
//                                         consumedCalories: calorieData['consumed']!,
//                                         remainingCalories: calorieData['remaining']!,
//                                       ),
//                                     ),
//                                   ).then((_) {
//                                     setState(() {});
//                                   });
//                                 },
//                                 bmr: bmr,
//                               ),
//                               const SizedBox(height: 16),
//                               const StepCounterWidget(),
//                               const SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.white,
//             elevation: 8,
//             selectedItemColor: const Color(0xFF1A75FF),
//             unselectedItemColor: Colors.grey,
//             currentIndex: _selectedIndex,
//             onTap: (index) {
//               if (index != _selectedIndex) {
//                 final args = {
//                   'firstName': firstName,
//                   'bmi': bmi,
//                   'bmr': bmr,
//                 };
//                 AppNavigator.navigateToTabScreen(context, index,
//                     arguments: args);
//               } else {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               }
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.dumbbell),
//                 label: 'Workouts',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.message),
//                 label: 'Chatbot',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.utensils),
//                 label: 'Recipes',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.user),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }