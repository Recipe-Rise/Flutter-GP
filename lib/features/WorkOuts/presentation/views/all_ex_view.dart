import 'package:fitfork_gp/features/WorkOuts/presentation/cubit/cubit.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WorkOutsView extends StatelessWidget {
  const WorkOutsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOutCubit , WorkOutsStates>(
      listener: (context , state) {
        if (state is WorkOutsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context , state) {

        if (state is WorkOutsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (WorkOutCubit.get(context).exercisesList.isEmpty) {
          return const Center(child: Text('No workouts available.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20.0),
            itemBuilder: (context , index) {
            final workout = WorkOutCubit.get(context).exercisesList[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.name ?? "unknown",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Target : ${workout.target ?? "N/A"}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Equipment : ${workout.equipment ?? "N/A"}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (workout.instructions != null && workout.instructions!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Instructions:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ...workout.instructions!.asMap().entries.map(
                              (entry){
                                final stepNumber = entry.key + 1;
                                final instruction = entry.value;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    '$stepNumber. $instruction',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                );
                              }
                            )
                          ],
                        )
                    ],
                  ),
                ),
              );
            } ,
            separatorBuilder: (context , index) => const Divider(color: Colors.grey,),
            itemCount: WorkOutCubit.get(context).exercisesList.length,
        );
      },
    );
  }
}