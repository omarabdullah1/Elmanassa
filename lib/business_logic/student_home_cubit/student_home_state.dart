
import 'package:flutter/material.dart';

import '../../data/models/account_model.dart';
import '../../data/models/course_dashboard_model.dart';
import '../../data/models/course_details_model.dart';
import '../../data/models/course_subscriptions_model.dart';
import '../../data/models/levels_model.dart';
import '../../data/models/quiz_model.dart';
import '../../data/models/quizs_degrees_model.dart';
import '../../data/models/subscribe_model.dart';
import '../../data/models/support_model.dart';

@immutable
abstract class StudentHomeState {}

class StudentHomeInitial extends StudentHomeState {}

class GetCoursesLoadingState extends StudentHomeState {}

class GetCoursesSuccessState extends StudentHomeState {}

class GetCoursesErrorState extends StudentHomeState {
  final String error;

  GetCoursesErrorState(this.error);
}

class GetMyCoursesLoadingState extends StudentHomeState {}

class GetMyCoursesSuccessState extends StudentHomeState {}

class GetMyCoursesErrorState extends StudentHomeState {
  final String error;

  GetMyCoursesErrorState(this.error);
}

class GetNotificationLoadingState extends StudentHomeState {}

class GetNotificationSuccessState extends StudentHomeState {}

class GetNotificationErrorState extends StudentHomeState {
  final String error;

  GetNotificationErrorState(this.error);
}

class GetProfileLoadingState extends StudentHomeState {}

class GetProfileSuccessState extends StudentHomeState {}

class GetProfileErrorState extends StudentHomeState {
  final String error;

  GetProfileErrorState(this.error);
}

class GetBannersLoadingState extends StudentHomeState {}

class GetBannersSuccessState extends StudentHomeState {}

class GetBannersErrorState extends StudentHomeState {
  final String error;

  GetBannersErrorState(this.error);
}

class AppChangeIsVideosState extends StudentHomeState {}

class AppChangeIsOpenState extends StudentHomeState {}

class AppChangeScreenIndexState extends StudentHomeState {}

class AppChangeDrawerScreenIndexState extends StudentHomeState {}

class AppChangeSelectedPackageIndexState extends StudentHomeState {}

class AppChangePaymentBoxColorState extends StudentHomeState {}

class AppChangePaymentBoxIconState extends StudentHomeState {}

class AppChangePaymentButtonState extends StudentHomeState {}

class AppChangeQuizBoxColorState extends StudentHomeState {}

class AppChangeQuizBoxIconState extends StudentHomeState {}

class AppChangeQuizButtonState extends StudentHomeState {}

class AppChangeCarosalState extends StudentHomeState {}

class AppChangeQuizState extends StudentHomeState {}

class GetCourseDetailsLoadingState extends StudentHomeState {}

class GetCourseDetailsSuccessState extends StudentHomeState {
  final CourseDetailsModel courseDetailsModel;

  GetCourseDetailsSuccessState(this.courseDetailsModel);
}

class GetCourseDetailsErrorState extends StudentHomeState {
  final String error;

  GetCourseDetailsErrorState(this.error);
}

class GetLevelsLoadingState extends StudentHomeState {}

class GetLevelsSuccessState extends StudentHomeState {
  final LevelsModel levelsModel;

  GetLevelsSuccessState(this.levelsModel);
}

class GetLevelsErrorState extends StudentHomeState {
  final String error;

  GetLevelsErrorState(this.error);
}

class LoginLoadingState extends StudentHomeState {}

class LoginSuccessState extends StudentHomeState {
  final AccountModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends StudentHomeState {
  final String error;

  LoginErrorState(this.error);
}

class RemoveImageSuccessState extends StudentHomeState {}

class PickImageLoadingState extends StudentHomeState {}

class PickImageSuccessState extends StudentHomeState {}

class PickImageErrorState extends StudentHomeState {}

class SubscribeLoadingState extends StudentHomeState {}

class SubscribeSuccessState extends StudentHomeState {
  final SubscribeModel subscribeModel;

  SubscribeSuccessState(this.subscribeModel);
}

class SubscribeErrorState extends StudentHomeState {
  final String error;

  SubscribeErrorState(this.error);
}

class GetCoursePackagesLoadingState extends StudentHomeState {}

class GetCoursePackagesSuccessState extends StudentHomeState {
  final CourseSubscriptionsModel courseSubscriptionsModel;

  GetCoursePackagesSuccessState(this.courseSubscriptionsModel);
}

class GetCoursePackagesErrorState extends StudentHomeState {
  final String error;

  GetCoursePackagesErrorState(this.error);
}

class GetCourseDashboardLoadingState extends StudentHomeState {}

class GetCourseDashboardSuccessState extends StudentHomeState {
  final CourseDashboardModel courseDashboardModel;

  GetCourseDashboardSuccessState(this.courseDashboardModel);
}

class GetCourseDashboardErrorState extends StudentHomeState {
  final String error;

  GetCourseDashboardErrorState(this.error);
}

class GetSupportLoadingState extends StudentHomeState {}

class GetSupportSuccessState extends StudentHomeState {
  final SupportModel supportModel;

  GetSupportSuccessState(this.supportModel);
}

class GetSupportErrorState extends StudentHomeState {
  final String error;

  GetSupportErrorState(this.error);
}

class StudentUpdateLoadingState extends StudentHomeState {}

class StudentUpdateSuccessState extends StudentHomeState {}

class StudentUpdateErrorState extends StudentHomeState {
  final String error;

  StudentUpdateErrorState(this.error);
}

class DrawerToggleState extends StudentHomeState {}

class ChangePasswordVisibilityState extends StudentHomeState {}

class AppChangeLocalState extends StudentHomeState {}

class AppChangeTimerState extends StudentHomeState {}

class LogoutLoadingState extends StudentHomeState {}

class LogoutSuccessState extends StudentHomeState {}

class LogoutErrorState extends StudentHomeState {
  final String error;

  LogoutErrorState(this.error);
}

class GetQuizDetailsLoadingState extends StudentHomeState {}

class GetQuizDetailsSuccessState extends StudentHomeState {
  final QuizModel quizModel;

  GetQuizDetailsSuccessState(this.quizModel);
}

class GetQuizDetailsErrorState extends StudentHomeState {
  final String error;

  GetQuizDetailsErrorState(this.error);
}

class StartQuizLoadingState extends StudentHomeState {}

class StartQuizSuccessState extends StudentHomeState {
  final QuizModel quizModel;

  StartQuizSuccessState(this.quizModel);
}

class StartQuizErrorState extends StudentHomeState {
  final String error;

  StartQuizErrorState(this.error);
}

class SubmitQuizQuesLoadingState extends StudentHomeState {}

class SubmitQuizQuesSuccessState extends StudentHomeState {}

class SubmitQuizQuesErrorState extends StudentHomeState {
  final String error;

  SubmitQuizQuesErrorState(this.error);
}

class SubmitQuizLoadingState extends StudentHomeState {}

class SubmitQuizSuccessState extends StudentHomeState {}

class SubmitQuizErrorState extends StudentHomeState {
  final String error;

  SubmitQuizErrorState(this.error);
}

class GetQuizsDegreesLoadingState extends StudentHomeState {}

class GetQuizsDegreesSuccessState extends StudentHomeState {
  final QuizsDegreesModel quizsDegreesModel;

  GetQuizsDegreesSuccessState(this.quizsDegreesModel);

}

class GetQuizsDegreesErrorState extends StudentHomeState {
  final String error;

  GetQuizsDegreesErrorState(this.error);
}
