import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/features/WorkOuts/data/model/work_outs_model.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/cubit/states.dart';
import 'package:fitfork_gp/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';

class WorkOutCubit extends Cubit<WorkOutsStates>{

  WorkOutCubit() : super(WorkOutsInitialState());

  static WorkOutCubit get(context) => BlocProvider.of(context);

  GetAllExcercises? getAllExcercises;

  void getAllExcercisesData() {
    emit(WorkOutsLoadingState());

    DioHelper.getData(
        url: ALLEXERCISES,
    ).then((value) {

      getAllExcercises = GetAllExcercises.fromJson(value?.data);
      emit(WorkOutsSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(WorkOutsErrorState(error.toString()));
    });
  }
}