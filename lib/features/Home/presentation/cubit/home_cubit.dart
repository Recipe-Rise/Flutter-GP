import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/features/Home/presentation/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);



}