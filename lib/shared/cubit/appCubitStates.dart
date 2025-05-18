import '../../features/Profile/data/user_data_model.dart';

abstract class AppStates {}

class AppInitial extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppLoadingUserDataState extends AppStates {}

class AppSuccessUserDataState extends AppStates {
  final GetUserData userData;

  AppSuccessUserDataState(this.userData);
}

class AppErrorUserDataState extends AppStates {
  final String error;

  AppErrorUserDataState(this.error);
}
