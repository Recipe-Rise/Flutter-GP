import '../../data/model/work_outs_model.dart';

abstract class WorkOutsStates {}

class WorkOutsInitialState extends WorkOutsStates {}

class WorkOutsLoadingState extends WorkOutsStates {}

class WorkOutsSuccessState extends WorkOutsStates {}

class WorkOutsErrorState extends WorkOutsStates {
  final String error;

  WorkOutsErrorState(this.error);
}

class WorkOutBodyPartsSuccessState extends WorkOutsStates {
  final List<String> bodyParts;

  WorkOutBodyPartsSuccessState(this.bodyParts);
}

class WorkOutsBodyPartsLoadingState extends WorkOutsStates {}

class WorkOutsBodyPartsErrorState extends WorkOutsStates {
  final String error;

  WorkOutsBodyPartsErrorState(this.error);
}

class WorkOutsBodyPartsSelectedState extends WorkOutsStates {
  final String selectedBodyPart;

  WorkOutsBodyPartsSelectedState(this.selectedBodyPart);
}


class WorkOutGetAllExcercisesBodyPartLoadingState extends WorkOutsStates {}

class WorkOutGetAllExcercisesBodyPartSuccessState extends WorkOutsStates {}

class WorkOutGetAllExcercisesBodyPartErrorState extends WorkOutsStates {
  final String error;

  WorkOutGetAllExcercisesBodyPartErrorState(this.error);
}

