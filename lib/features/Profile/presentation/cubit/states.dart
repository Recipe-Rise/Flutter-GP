import '../../data/logout_data_model.dart';
import '../../data/user_data_model.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  final GetUserData userData;

  ProfileSuccessState(this.userData);
}

class ProfileErrorState extends ProfileStates {
  final String error;

  ProfileErrorState(this.error);
}

class ProfileLogoutState extends ProfileStates {}

class ProfileLogoutSuccessState extends ProfileStates {
  final LogoutModel logoutModel;

  ProfileLogoutSuccessState(this.logoutModel);
}

class ProfileLogoutErrorState extends ProfileStates {
  final String error;

  ProfileLogoutErrorState(this.error);
}

class ProfileUpdateState extends ProfileStates {}

class ProfileUpdateLoadingState extends ProfileStates {}

class ProfileUpdateSuccessState extends ProfileStates {
  final GetUserData userData;

  ProfileUpdateSuccessState(this.userData);
}

class ProfileUpdateErrorState extends ProfileStates {
  final String error;

  ProfileUpdateErrorState(this.error);
}