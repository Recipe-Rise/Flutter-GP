abstract class WorkOutsStates {}

class WorkOutsInitialState extends WorkOutsStates {}

class WorkOutsLoadingState extends WorkOutsStates {}

class WorkOutsSuccessState extends WorkOutsStates {}

class WorkOutsErrorState extends WorkOutsStates {
  final String error;

  WorkOutsErrorState(this.error);
}
