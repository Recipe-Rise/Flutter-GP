import 'package:fitfork_gp/features/WorkOuts/presentation/views/each_workout_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class EachBodypartWorkouts extends StatelessWidget {
  final String bodyPart;

  const EachBodypartWorkouts({
    super.key,
    required this.bodyPart,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    WorkOutCubit.get(context).getAllExcercisesForBodyPartData(bodyPart: bodyPart);

    return Scaffold(
      appBar: AppBar(
        title: Text('$bodyPart Workouts'),
        backgroundColor: const Color(0xff4597ff),
      ),
      body: BlocConsumer<WorkOutCubit, WorkOutsStates>(
        listener: (context, state) {
          if (state is WorkOutGetAllExcercisesBodyPartErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is WorkOutGetAllExcercisesBodyPartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff4597ff)),
            );
          } else if (state is WorkOutGetAllExcercisesBodyPartSuccessState) {
            final exercises = WorkOutCubit.get(context).bodyPartExercisesList;

            return Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Card(
                    color: Color(0xFFEEF3FE),
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.04),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (exercise.gifUrl != null && exercise.gifUrl!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(size.width * 0.04),
                              child: Image.network(
                                exercise.gifUrl!,
                                height: size.height * 0.2,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Text('Image not available'),
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            exercise.name ?? '',
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            'Target Muscle: ${exercise.target ?? ''}',
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EachWorkoutDetails(exercise: exercise,);
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: const Text(
                                'View Details',
                                style: TextStyle(
                                    color: Color(0xff4597ff),
                                    fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: Text('No exercises found.'),
          );
        },
      ),
    );
  }
}