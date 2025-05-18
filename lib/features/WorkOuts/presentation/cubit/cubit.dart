import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/features/WorkOuts/data/model/work_outs_model.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/cubit/states.dart';
import 'package:fitfork_gp/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';

class WorkOutCubit extends Cubit<WorkOutsStates>{

  WorkOutCubit() : super(WorkOutsInitialState());

  static WorkOutCubit get(context) => BlocProvider.of(context);

  List<GetAllExcercises> exercisesList = [];


  GetAllExcercises? getAllExcercises;

  void getAllExcercisesData() {
    emit(WorkOutsLoadingState());

    DioHelper.getData(
        url: ALLEXERCISES,
    ).then((value) {

      exercisesList = (value?.data as List)
          .map((exercise) => GetAllExcercises.fromJson(exercise))
          .toList();

      print(exercisesList[0].instructions);

      getAllExcercises = GetAllExcercises.fromJson(value?.data);
      emit(WorkOutsSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(WorkOutsErrorState(error.toString()));
    });
  }

  GetAllExcercises? getAllExcercisesForBodyPart;

  List<GetAllExcercises> bodyPartExercisesList = [];

  void getAllExcercisesForBodyPartData({
    required String bodyPart
}) {

    emit(WorkOutGetAllExcercisesBodyPartLoadingState());

    DioHelper.getData(
      url: '$BODYPARTEXERCISES$bodyPart',
    ).then((value) {

      //getAllExcercisesForBodyPart = GetAllExcercises.fromJson(value?.data);

      bodyPartExercisesList = (value?.data as List<dynamic>)
          .map((exercise) => GetAllExcercises.fromJson(exercise as Map<String, dynamic>))
          .toList();

      emit(WorkOutGetAllExcercisesBodyPartSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(WorkOutGetAllExcercisesBodyPartErrorState(error.toString()));
    });
  }


  List<String> bodyParts = [];


  void getBodyParts() {

    emit(WorkOutsBodyPartsLoadingState());

    DioHelper.getData(
      url: BODYPARTLIST,
    ).then((value) {

      final bodyParts = (value?.data as List).cast<String>();
      emit(WorkOutBodyPartsSuccessState(bodyParts));

    }).catchError((error) {
      print(error.toString());
      emit(WorkOutsBodyPartsErrorState(error.toString()));
    });
  }

}