part of 'parent_home_cubit.dart';

@immutable
abstract class ParentHomeState {}

class ParentHomeInitial extends ParentHomeState {}

class LoginParentLoadingState extends ParentHomeState {}

class LoginParentSuccessState extends ParentHomeState {
  final ParentModel parentModel;

  LoginParentSuccessState(this.parentModel);
}

class LoginParentErrorState extends ParentHomeState {
  final String error;

  LoginParentErrorState(this.error);
}

class AppChangeScreenIndexState extends ParentHomeState {}

class AppChangeQrState extends ParentHomeState {}
class AppChangeLanguageState extends ParentHomeState {}

class AddParentStudentLoadingState extends ParentHomeState {}

class AddParentStudentSuccessState extends ParentHomeState {}

class AddParentStudentErrorState extends ParentHomeState {
  final String error;

  AddParentStudentErrorState(this.error);
}

class GetParentStudentLoadingState extends ParentHomeState {}

class GetParentStudentSuccessState extends ParentHomeState {}

class GetParentStudentErrorState extends ParentHomeState {
  final String error;

  GetParentStudentErrorState(this.error);
}