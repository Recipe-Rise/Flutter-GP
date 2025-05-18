import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'body_part_card.dart';

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
                    'Full Body Workout',
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
                          final bodyParts = state.bodyParts;
                          return ListView.builder(
                            itemCount: bodyParts.length,
                            itemBuilder: (context, index) {
                              final bodyPart = bodyParts[index];
                              return BodyPartCard(
                                name: bodyPart,
                                imageUrl: AssetsData.reg2,
                                onArrowPressed: () {

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