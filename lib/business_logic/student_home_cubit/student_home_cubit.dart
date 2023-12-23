import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edumaster/business_logic/student_home_cubit/student_home_state.dart';
import 'package:edumaster/data/models/banners_model.dart';
import 'package:edumaster/data/models/course_dashboard_model.dart';
import 'package:edumaster/data/models/course_details_model.dart';
import 'package:edumaster/data/models/course_subscriptions_model.dart';
import 'package:edumaster/data/models/subscribe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/end_points.dart';
import '../../data/local/cache_helper.dart';
import '../../data/models/courses_model.dart';
import '../../data/models/levels_model.dart';
import '../../data/remote/dio_helper.dart';
import '../../presentation/screens/user/home/home_screen.dart';
import '../../presentation/screens/user/my_courses/myCourses_screen.dart';
import '../../presentation/screens/user/profile/profile_screen.dart';

class StudentHomeCubit extends Cubit<StudentHomeState> {
  StudentHomeCubit() : super(StudentHomeInitial());

  CoursesModel? coursesModel;
  CoursesModel? myCoursesModel;
  CourseDetailsModel? courseDetailsModel;
  CourseDashboardModel? courseDashboardModel;
  LevelsModel? levelsModel;
  BannersModel? bannersModel;
  SubscribeModel? subscribeModel;
  CourseSubscriptionsModel? courseSubscriptionsModel;

  bool isVideos = false;
  List<String>? allBanners = [];
  List<String>? allLevelsOrder = [];
  List<String> allLevelsTitle = [
    'اختر المستوي',
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const MyCoursesScreen(),
    // const NotificationScreen(),
    const ProfileScreen(),
  ];
  int screenIndex = 0;
  int selectedPackage = 0;
  List listImage = [];
  String? myId = CacheHelper.sharedPreferences.getInt('id').toString();
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> getBanners() async {
    emit(GetBannersLoadingState());
    await DioHelper.getData(url: banners).then((value) {
      allBanners!.clear();
      bannersModel = BannersModel.fromJson(value.data);
      for (var element in bannersModel!.banners!) {
        allBanners!.add('$domain/${element!.image!}');
      }
      emit(GetBannersSuccessState());
    }).catchError((error) {
      emit(GetBannersErrorState(error.toString()));
    });
  }

  Future<void> getCourses() async {
    if (CacheHelper.getDataFromSharedPreference(key: 'token') != null) {
      emit(GetCoursesLoadingState());
      await DioHelper.getDataWithToken(
        url: courses,
        token: CacheHelper.getDataFromSharedPreference(key: 'token'),
      ).then((value) {
        coursesModel = CoursesModel.fromJson(value.data);
        emit(GetCoursesSuccessState());
      }).catchError((error) {
        emit(GetCoursesErrorState(error.toString()));
      });
    } else {
      emit(GetCoursesLoadingState());
      await DioHelper.getData(url: courses).then((value) {
        coursesModel = CoursesModel.fromJson(value.data);
        emit(GetCoursesSuccessState());
      }).catchError((error) {
        emit(GetCoursesErrorState(error.toString()));
      });
    }
  }

  Future<void> getCoursesByLevel(int level) async {
    emit(GetCoursesLoadingState());
    await DioHelper.postData(
      url: courseFiltered,
      body: {
        "filter": {
          "level_id": level,
        },
        '_method': 'GET',
      },
    ).then((value) {
      coursesModel = CoursesModel.fromJson(value.data);
      emit(GetCoursesSuccessState());
    }).catchError((error) {
      emit(GetCoursesErrorState(error.toString()));
    });
  }

  Future<void> getCourseDetails({
    required String id,
  }) async {
    emit(GetCourseDetailsLoadingState());

    DioHelper.postData(
      url: courseDetails,
      body: {
        'id': id,
        '_method': 'GET',
      },
    ).then((value) {
      courseDetailsModel = CourseDetailsModel.fromJson(value.data);
      emit(GetCourseDetailsSuccessState(courseDetailsModel!));
    }).catchError((error) {
      emit(GetCourseDetailsErrorState(error.toString()));
    });
  }

  Future<void> getLevels() async {
    emit(GetLevelsLoadingState());

    await DioHelper.getData(
      url: levels,
    ).then((value) {
      log(value.data.toString());
      levelsModel = LevelsModel.fromJson(value.data);
      allLevelsTitle.clear();
      allLevelsTitle.add('اختر المستوي');
      for (var element in levelsModel!.levels!) {
        allLevelsTitle.add(element!.title!);
        allLevelsOrder!.add(element.order!.toString());
      }
      emit(GetLevelsSuccessState(levelsModel!));
    }).catchError((error) {
      log(error.toString());
      emit(GetLevelsErrorState(error.toString()));
    });
  }

  changeIsVideosValue() {
    emit(AppChangeIsVideosState());
  }

  // bool isOpen = false;

  changeExpandableState() {
    // isOpen = !isOpen;
    emit(AppChangeIsOpenState());
  }

  changeScreenIndexState(int index) {
    screenIndex = index;
    emit(AppChangeScreenIndexState());
  }

  removeImageFromList(index) {
    listImage.removeAt(index);
    emit(RemoveImageSuccessState());
  }

  // Future<void> getMultiImage(bool isCamera) async {
  //   var picker = ImagePicker();
  //   emit(PickImageLoadingState());
  //   final List<XFile> pickedFileList = await picker.pickMultiImage(
  //     maxWidth: 300,
  //     maxHeight: 300,
  //     imageQuality: 100,
  //   );
  //   // final pickedFile = await picker.pickImage(
  //   //     source: ImageSource.gallery);
  //   // listImage = File(pickedFile.path);
  //   for (var ele in pickedFileList) {
  //     listImage.add(ele.path);
  //   }
  //   emit(PickImageSuccessState());
  // }

  Future<void> getImage(bool isCamera) async {
    emit(PickImageLoadingState());
    var picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      listImage.clear();
      listImage.add(pickedFile.path);
      emit(PickImageSuccessState());
    } else {
      // log('No image selected.');
      emit(PickImageErrorState());
    }
  }

  // Future<void> userSubscribe({
  //   required String subscriptionId,
  // }) async {
  //   emit(SubscribeLoadingState());
  //   List files = [];
  //   FormData formData = FormData();
  //
  //   for (var element in listImage) {
  //     files.add(File(element));
  //   }
  //   List<MultipartFile> multiPartFiles = [];
  //   for (int i = 0; i < files.length; i++) {
  //     multiPartFiles.add(
  //       await MultipartFile.fromFile(
  //         files[i].path,
  //         filename: files[i].path,
  //       ),
  //     );
  //   }
  //   Map<String, dynamic> body = {
  //     'subscription_id': int.parse(subscriptionId),
  //     'student_id': CacheHelper.sharedPreferences.get('id'),
  //     'image': multiPartFiles,
  //     'type': 'package',
  //   };
  //   body.forEach((key, value) {
  //     formData.fields.add(MapEntry(key, value.toString()));
  //   });
  //   await DioHelper.postDataWithTokenAndFiles(
  //     url: subscribeToCourseStudentPath,
  //     token: CacheHelper.sharedPreferences.get('token').toString(),
  //     body: formData,
  //   ).then((value) {
  //     log(value.data.toString());
  //     subscribeModel = SubscribeModel.fromJson(value.data);
  //     log(subscribeModel!.message!);
  //     emit(SubscribeSuccessState(subscribeModel!));
  //   }).catchError((error) {
  //     log(error.toString());
  //     emit(SubscribeErrorState(error.toString()));
  //   });
  // }

  Future<void> userSubscribeById({
    required String subscriptionId,
  }) async {
    try {
      emit(SubscribeLoadingState());

      // Convert image path to a File object
      File file = File(listImage.first);

      // // Convert File object to MultipartFile object
      // MultipartFile multiPartFile = await MultipartFile.fromFile(
      //   file.path,
      //   filename: file.path,
      // );

      // Build request body
      FormData formData = FormData.fromMap({
        'subscription_id': int.parse(subscriptionId),
        'student_id': CacheHelper.sharedPreferences.get('id'),
        'type': 'package',
        'image': await MultipartFile.fromFile(
          file.path,
          filename: file.path,
        ),
      });

      // Make API call
      var response = await DioHelper.postDataWithTokenAndFiles(
        url: subscribeToCourseByIdStudentPath,
        token: CacheHelper.sharedPreferences.get('token').toString(),
        body: formData,
      );

      // Handle API response
      log(response.data.toString());
      subscribeModel = SubscribeModel.fromJson(response.data);
      log(subscribeModel!.message!);
      emit(SubscribeSuccessState(subscribeModel!));
    } catch (error) {
      log(error.toString());
      emit(SubscribeErrorState(error.toString()));
    }
  }

  Future<void> userSubscribeForFree({
    required String subscriptionId,
  }) async {
    try {
      emit(SubscribeLoadingState());
      // Make API call
      var response = await DioHelper.postDataWithToken(
        url: subscribeToCourseByIdStudentPath,
        token: CacheHelper.sharedPreferences.get('token').toString(),
        body: {
          'subscription_id': int.parse(subscriptionId),
          'student_id': CacheHelper.sharedPreferences.get('id'),
          'type': 'package',
        },
      );

      // Handle API response
      log(response.data.toString());
      subscribeModel = SubscribeModel.fromJson(response.data);
      log(subscribeModel!.message!);
      emit(SubscribeSuccessState(subscribeModel!));
    } catch (error) {
      log(error.toString());
      emit(SubscribeErrorState(error.toString()));
    }
  }

  Future<void> userSubscribeByCode({
    required String subscriptionCode,
  }) async {
    try {
      emit(SubscribeLoadingState());
      // Make API call
      var response = await DioHelper.postDataWithToken(
        url: subscribeToCourseByCodeStudentPath,
        token: CacheHelper.sharedPreferences.get('token').toString(),
        body: {
          'code': subscriptionCode,
          'student_id': CacheHelper.sharedPreferences.get('id'),
          'type': 'package',
        },
      );

      // Handle API response
      log(response.data.toString());
      subscribeModel = SubscribeModel.fromJson(response.data);
      log(subscribeModel!.message!);
      emit(SubscribeSuccessState(subscribeModel!));
    } catch (error) {
      log(error.toString());
      emit(SubscribeErrorState(error.toString()));
    }
  }

  void getCoursePackages({required String courseId}) {
    emit(GetCoursePackagesLoadingState());

    DioHelper.postDataWithToken(
      url: coursePackagesStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        'id': courseId,
        '_method': 'GET',
      },
    ).then((value) {
      log(value.data.toString());
      courseSubscriptionsModel = CourseSubscriptionsModel.fromJson(value.data);
      log(courseSubscriptionsModel!.subscriptions!.first!.id.toString());
      emit(GetCoursePackagesSuccessState(courseSubscriptionsModel!));
    }).catchError((error) {
      log(error.toString());
      // print(error.toString());
      emit(GetCoursePackagesErrorState(error.toString()));
    });
  }

  Future<void> getMyCourses() async {
    emit(GetMyCoursesLoadingState());
    await DioHelper.postDataWithToken(
      url: enrolledCoursesStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "id": CacheHelper.sharedPreferences.get('id'),
        '_method': 'GET',
      },
    ).then((value) {
      myCoursesModel = CoursesModel.fromJson(value.data);
      emit(GetMyCoursesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetMyCoursesErrorState(error.toString()));
    });
  }

  Future<void> getCourseDashboard({
    required String id,
  }) async {
    emit(GetCourseDashboardLoadingState());

    DioHelper.postDataWithToken(
      url: courseDashboardStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        'id': id,
        '_method': 'GET',
      },
    ).then((value) {
      courseDashboardModel = CourseDashboardModel.fromJson(value.data);

      emit(GetCourseDashboardSuccessState(courseDashboardModel!));
    }).catchError((error) {
      emit(GetCourseDashboardErrorState(error.toString()));
    });
  }

  changeSelectedPackageIndexState(int index) {
    selectedPackage = index;
    emit(AppChangeSelectedPackageIndexState());
  }
}
