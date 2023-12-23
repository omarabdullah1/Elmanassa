import 'package:edumaster/data/models/course_dashboard_model.dart';
import 'package:edumaster/data/models/course_details_model.dart';
import 'package:edumaster/data/models/course_subscriptions_model.dart';
import 'package:edumaster/data/models/levels_model.dart';
import 'package:edumaster/data/models/subscribe_model.dart';
import 'package:flutter/material.dart';

import '../../data/models/account_model.dart';

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

class GetBannersLoadingState extends StudentHomeState {}

class GetBannersSuccessState extends StudentHomeState {}

class GetBannersErrorState extends StudentHomeState {
  final String error;

  GetBannersErrorState(this.error);
}

class AppChangeIsVideosState extends StudentHomeState {}

class AppChangeIsOpenState extends StudentHomeState {}

class AppChangeScreenIndexState extends StudentHomeState {}

class AppChangeSelectedPackageIndexState extends StudentHomeState {}

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
