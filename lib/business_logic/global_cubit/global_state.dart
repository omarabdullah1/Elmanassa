part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LoginLoadingState extends GlobalState {}

class LoginSuccessState extends GlobalState {
  final AccountModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends GlobalState {
  final String error;

  LoginErrorState(this.error);
}

class LoginParentLoadingState extends GlobalState {}

class LoginParentSuccessState extends GlobalState {
  final ParentModel parentModel;

  LoginParentSuccessState(this.parentModel);
}

class LoginParentErrorState extends GlobalState {
  final String error;

  LoginParentErrorState(this.error);
}

class StudentRegisterLoadingState extends GlobalState {}

class StudentRegisterSuccessState extends GlobalState {}

class StudentRegisterErrorState extends GlobalState {
  final String error;

  StudentRegisterErrorState(this.error);
}

class ParentRegisterLoadingState extends GlobalState {}

class ParentRegisterSuccessState extends GlobalState {}

class ParentRegisterErrorState extends GlobalState {
  final String error;

  ParentRegisterErrorState(this.error);
}

class ChangePasswordVisibilityState extends GlobalState {}

class AppChangeLanguageState extends GlobalState {}

class AppChangeIsParentState extends GlobalState {}

class GetLevelsLoadingState extends GlobalState {}

class GetLevelsSuccessState extends GlobalState {
  final LevelsModel levelsModel;

  GetLevelsSuccessState(this.levelsModel);
}

class GetLevelsErrorState extends GlobalState {
  final String error;

  GetLevelsErrorState(this.error);
}

class AppChangeQrSuccessState extends GlobalState {}

class AppChangeQrErrorState extends GlobalState {}

class AppRemoveQrState extends GlobalState {}

class AppChangeLocalState extends GlobalState {}
