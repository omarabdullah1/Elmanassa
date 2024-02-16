import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:edumaster/business_logic/student_home_cubit/student_home_state.dart';
import 'package:edumaster/data/models/banners_model.dart';
import 'package:edumaster/data/models/course_dashboard_model.dart';
import 'package:edumaster/data/models/course_details_model.dart';
import 'package:edumaster/data/models/course_subscriptions_model.dart';
import 'package:edumaster/data/models/profile_model.dart';
import 'package:edumaster/data/models/quiz_model.dart';
import 'package:edumaster/data/models/quizs_degrees_model.dart';
import 'package:edumaster/data/models/subscribe_model.dart';
import 'package:edumaster/data/models/support_model.dart';
import 'package:edumaster/presentation/screens/user/degree/degree_screen.dart';
import 'package:edumaster/presentation/screens/user/quiz/quiz_screen.dart';
import 'package:edumaster/presentation/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/end_points.dart';
import '../../constants/screens.dart';
import '../../data/local/args.dart';
import '../../data/local/cache_helper.dart';
import '../../data/models/courses_model.dart';
import '../../data/models/levels_model.dart';
import '../../data/models/notification_model.dart';
import '../../data/remote/dio_helper.dart';
import '../../main.dart';
import '../../presentation/screens/user/home/home_screen.dart';
import '../../presentation/screens/user/my_courses/my_courses_screen.dart';
import '../../presentation/screens/user/notification/notification_screen.dart';
import '../../presentation/screens/user/profile/profile_screen.dart';
import '../../presentation/styles/texts.dart';
import '../../presentation/widget/toast.dart';
import '../app_localization.dart';

class StudentHomeCubit extends Cubit<StudentHomeState> {
  StudentHomeCubit() : super(StudentHomeInitial());

  final paymentCodeController = TextEditingController();
  final quizCodeController = TextEditingController();
  String? quizCode;
  Color paymentBoxColor = AppColor.honeyYellow;
  IconData? paymentCodeIcon;
  Color quizBoxColor = AppColor.honeyYellow;
  IconData? quizCodeIcon;

  CoursesModel? coursesModel;
  CoursesModel? myCoursesModel;
  CourseDetailsModel? courseDetailsModel;
  CourseDashboardModel? courseDashboardModel;
  NotificationModel? notificationModel;
  LevelsModel? levelsModel;
  BannersModel? bannersModel;
  SubscribeModel? subscribeModel;
  CourseSubscriptionsModel? courseSubscriptionsModel;
  SupportModel? supportModel;
  ProfileModel? profileModel;
  QuizModel? quizModel;
  QuizsDegreesModel? quizsDegreesModel;

  final CarouselController carouselController = CarouselController();
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  final formKey = GlobalKey<FormState>();

  final sEmailController = TextEditingController();

  final sPhoneController = TextEditingController();

  final sFirstNameController = TextEditingController();

  final sSecondNameController = TextEditingController();

  final quizController = PageController();

  bool isQuizLast = false;
  bool isQuizFirst = true;
  Map<int, int> quizQuestionSelectedValues = {};
  List<int> quizQuestionSelectedValuesList = [];

  String? selectedLevel = 'اختر المستوي';
  String? selectedGender = 'اختر النوع';
  List<String> allLevelsTitle = [
    'اختر المستوي',
  ];
  List<String> genderList = [
    'اختر النوع',
    'ذكر',
    'انثي',
  ];
  List<String> genderListEN = [
    'select gender',
    'male',
    'female',
  ];

  int currentPage = 0;

  bool isVideos = false;
  bool paymentButtonState = false;
  bool quizButtonState = false;

  List<String>? allBanners = [];
  List<String>? allLevelsOrder = [];

  List<Widget> screens = [
    const HomeScreen(),
    const MyCoursesScreen(),
    const NotificationScreen(),
  ];
  String screenTitles(context,index) {
   switch(index){
     case 0:
       return Texts.translate('studentHomeHomepageText', context);
     case 1:
       return Texts.translate('studentHomeMyCoursesText', context);
     case 2:
       return Texts.translate('studentHomeNotificationText', context);
     default:
       return '';
   }
  }
  int screenIndex = 0;
  int drawerScreenIndex = 0;
  int selectedPackage = 0;
  List listImage = [];
  String? myId = CacheHelper.sharedPreferences.getInt('id').toString();

  final codeController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        url: authCourses,
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
    await DioHelper.postDataWithToken(
      token: CacheHelper.getDataFromSharedPreference(key: 'token'),
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
    drawerScreenIndex = 0;
    emit(AppChangeScreenIndexState());
  }

  changeDrawerScreenIndexState(int index) {
    drawerScreenIndex = index;
    emit(AppChangeDrawerScreenIndexState());
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
      log(error.toString());
      emit(GetMyCoursesErrorState(error.toString()));
    });
  }

  Future<void> getNotification() async {
    emit(GetNotificationLoadingState());
    await DioHelper.postDataWithToken(
      url: notificationStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "id": CacheHelper.sharedPreferences.get('id'),
        '_method': 'GET',
      },
    ).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      // print(notificationModel!.notifications!.first!.title);
      emit(GetNotificationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNotificationErrorState(error.toString()));
    });
  }

  Future<void> getProfile() async {
    emit(GetProfileLoadingState());
    await DioHelper.postDataWithToken(
      url: profileStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "id": CacheHelper.sharedPreferences.get('id'),
        '_method': 'GET',
      },
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      // print(profileModel!.profile!.email!.toString());
      sFirstNameController.text = profileModel!.profile!.firstName.toString();
      sSecondNameController.text = profileModel!.profile!.lastName.toString();
      sEmailController.text = profileModel!.profile!.email.toString();
      sPhoneController.text = profileModel!.profile!.phone.toString();
      selectedGender = genderList[
          genderListEN.indexOf(profileModel!.profile!.gender!.toString())];
      selectedLevel = allLevelsTitle[
          allLevelsOrder!.indexOf(profileModel!.profile!.levelId.toString()) +
              1];
      print(selectedGender);
      print(selectedLevel);
      print(allLevelsOrder);
      print(profileModel!.profile!.levelId.toString());
      emit(GetProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileErrorState(error.toString()));
    });
  }

  Future<void> getCourseDashboard({
    required String id,
  }) async {
    emit(GetCourseDashboardLoadingState());
    print(id.toString());

    print('iam here');

    await DioHelper.postDataWithToken(
      url: courseDashboardStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        'id': id,
        '_method': 'GET',
      },
    ).then((value) {
      // print(value.data.toString());
      courseDashboardModel = CourseDashboardModel.fromJson(value.data);
      print(courseDashboardModel!.course!.units.toString());
      emit(GetCourseDashboardSuccessState(courseDashboardModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetCourseDashboardErrorState(error.toString()));
    });
  }

  Future<void> getSupport() async {
    emit(GetSupportLoadingState());
    print('iam here');

    await DioHelper.getDataWithToken(
      url: supportPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
    ).then((value) {
      print(value.data.toString());
      supportModel = SupportModel.fromJson(value.data);
      print(supportModel!.supportInfo!.first!.value.toString());
      print(supportModel!.supportInfo!.first!.key.toString());
      emit(GetSupportSuccessState(supportModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetSupportErrorState(error.toString()));
    });
  }

  void userUpdate({
    required String email,
    required String phone,
    required String gender,
    required String fname,
    required String lname,
    required context,
  }) {
    Map<String, dynamic> myData = {
      '_method': 'PUT',
      'id': CacheHelper.sharedPreferences.get('id'),
      'email': email,
      'first_name': fname,
      'last_name': lname,
      'phone': phone,
      'gender': genderListEN[genderList.indexOf(selectedGender!)],
      'level_id': allLevelsOrder![allLevelsTitle.indexOf(selectedLevel!) - 1]
    };
    emit(StudentUpdateLoadingState());
    DioHelper.postDataWithToken(
      token: CacheHelper.sharedPreferences.get('token').toString(),
      url: profileStudentPath,
      body: myData,
    ).then((value) {
      // studentUpdateModel = StudentUpdateModel.fromJson(value.data);
      // print(value.data.toString());
      fToast.init(context);
      showToast('تم تحديث الحساب');
      emit(StudentUpdateSuccessState());
    }).catchError((error) {
      // print(myData);
      // print(error.toString());
      fToast.init(context);
      showToast('خطأ في تحديث الحساب');
      emit(StudentUpdateErrorState(error.toString()));
    });
  }

  Future<void> logOut(BuildContext context) async {
    emit(LogoutLoadingState());
    await DioHelper.postDataWithToken(
      url: logoutStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {},
    ).then((value) async {
      await CacheHelper.sharedPreferences.clear().then((value) async {
        await CacheHelper.sharedPreferences.remove('token').then((value) {
          Navigator.pushNamed(
            context,
            Screens.entryScreen,
          );
        });
      });
      emit(LogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LogoutErrorState(error.toString()));
    });
  }

  Future<void> getQuizDetails({
    required String id,
  }) async {
    emit(GetQuizDetailsLoadingState());
    print(id.toString());
    await DioHelper.postDataWithToken(
      url: quizDetailsStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "filter": {
          "id": id //quiz id
          // "code": "89Ga53" // quiz title
        },
        "_method": "GET"
      },
    ).then((value) {
      print(value.data.toString());
      quizModel = QuizModel.fromJson(value.data);
      quizCode = id.toString();
      quizModel!.quiz!.questions!.length == 1
          ? isQuizLast = true
          : isQuizLast = false;
      print(quizModel!.quiz!.title.toString());
      emit(GetQuizDetailsSuccessState(quizModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetQuizDetailsErrorState(error.toString()));
    });
  }

  Future<void> startQuizByCode({
    required String code,
  }) async {
    emit(GetQuizDetailsLoadingState());
    print(code.toString());
    await DioHelper.postDataWithToken(
      url: startQuizByCodeStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "code": code,
      },
    ).then((value) {
      print(value.data.toString());
      quizModel = QuizModel.fromJson(value.data);
      CacheHelper.sharedPreferences.setString('isQuizStarted', 'true');
      CacheHelper.sharedPreferences
          .setString('quizID', quizModel!.quiz!.id!.toString());
      quizCode = code.toString();
      print(quizModel!.quiz!.title.toString());
      emit(GetQuizDetailsSuccessState(quizModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetQuizDetailsErrorState(error.toString()));
    });
  }

  Future<void> startQuiz({
    required String id,
  }) async {
    emit(StartQuizLoadingState());
    print(id.toString());
    await DioHelper.postDataWithToken(
      url: quizDetailsStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "id": id,
      },
    ).then((value) {
      print(value.data.toString());
      quizModel = QuizModel.fromJson(value.data);
      quizCode = id.toString();
      print(quizModel!.quiz!.title.toString());
      emit(StartQuizSuccessState(quizModel!));
    }).catchError((error) {
      print(error.toString());
      emit(StartQuizErrorState(error.toString()));
    });
  }

  Future<void> submitQuizQuestion({
    required String quizID,
    required String quesID,
    required String quesAnswer,
  }) async {
    print(quizID.toString());
    print(quesID.toString());
    print(quesAnswer.toString());

    emit(SubmitQuizQuesLoadingState());
    await DioHelper.postDataWithToken(
      url: submitQuizquestionStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "quiz_id": quizID,
        "question_id": quesID,
        "student_id": CacheHelper.sharedPreferences.get('id'),
        "question_answer": quesAnswer
        // true or false / choice
      },
    ).then((value) {
      print(value.data.toString());
      quizQuestionSelectedValuesList.clear();
      quizQuestionSelectedValues.forEach((key, value) {
        quizQuestionSelectedValuesList.add(value);
      });
      print(quizQuestionSelectedValuesList);
      CacheHelper.sharedPreferences.setString('quizQuestionSelectedValuesList',
          quizQuestionSelectedValuesList.toString());
      emit(SubmitQuizQuesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SubmitQuizQuesErrorState(error.toString()));
    });
  }

  Future<void> submitQuiz({
    required String quizID,
  }) async {
    print(quizID.toString());
    emit(SubmitQuizLoadingState());
    await DioHelper.postDataWithToken(
      url: submitQuizStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        "quiz_id": quizID,
      },
    ).then((value) {
      print(value.data.toString());
      CacheHelper.sharedPreferences.remove('isQuizStarted');
      CacheHelper.sharedPreferences.remove('quizQuestionSelectedValuesList');
      emit(SubmitQuizSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SubmitQuizErrorState(error.toString()));
    });
  }

  Future<void> getQuizsDegrees() async {
    emit(GetQuizsDegreesLoadingState());
    await DioHelper.getDataWithToken(
      url: getQuizsStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
    ).then((value) {
      print(value.data.toString());
      quizsDegreesModel = QuizsDegreesModel.fromJson(value.data);
      emit(GetQuizsDegreesSuccessState(quizsDegreesModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetQuizsDegreesErrorState(error.toString()));
    });
  }

  changeSelectedPackageIndexState(int index) {
    selectedPackage = index;
    emit(AppChangeSelectedPackageIndexState());
  }

  changePaymentBoxColor(Color color) {
    paymentBoxColor = color;
    emit(AppChangePaymentBoxColorState());
  }

  changePaymentBoxIcon(IconData? icon) {
    paymentCodeIcon = icon;
    emit(AppChangePaymentBoxIconState());
  }

  changePaymentButtonState(bool state) {
    paymentButtonState = state;
    emit(AppChangePaymentButtonState());
  }

  changeQuizBoxColor(Color color) {
    quizBoxColor = color;
    emit(AppChangeQuizBoxColorState());
  }

  changeQuizBoxIcon(IconData? icon) {
    quizCodeIcon = icon;
    emit(AppChangeQuizBoxIconState());
  }

  changeQuizButtonState(bool state) {
    quizButtonState = state;
    emit(AppChangeQuizButtonState());
  }

  changeCarosalState(int index) {
    currentPage = index;
    emit(AppChangeCarosalState());
  }

  changeQuizState() {
    emit(AppChangeQuizState());
  }

  void toggleDrawer() => emit(DrawerToggleState());

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  void changeLocalState() {
    emit(AppChangeLocalState());
  }

  void changeQuizAnswerState(int quizID, int answer) {
    // quizQuestionSelectedValue= answer;
    if (quizQuestionSelectedValues.containsKey(quizID)) {
      quizQuestionSelectedValues.update(
        quizID,
        (value) => answer,
      );
    } else {
      quizQuestionSelectedValues.addAll(
        ({
          quizID: answer,
        }),
      );
    }

    emit(AppChangeLocalState());
  }

  Future<void> getProfileUpdateData() async {
    await getLevels().then((value) async {
      await getProfile();
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> checkIsQuizLast(context) async {
    // CacheHelper.sharedPreferences.remove('isQuizStarted');
    // CacheHelper.sharedPreferences.remove('quizID');
    if (CacheHelper.sharedPreferences.get('isQuizStarted') != null) {
      if (CacheHelper.sharedPreferences.get('isQuizStarted') == 'true') {
        Navigator.pushNamed(
          context,
          Screens.quizHomeScreen,
          arguments: ScreenArguments(
            'id',
            CacheHelper.sharedPreferences.get('quizID').toString(),
          ),
        );
      }
    }
    emit(AppChangeLocalState());
  }

  Future<void> getHomeData(context) async {
    await getCourses().then((value) async {
      return await getBanners().then((value) async {
        return await getLevels().then((value) async {
          return await getMyCourses().then((value) async {
            return await getNotification().then((value) {
              return checkIsQuizLast(context);
            });
          });
        });
      });
    });
  }

  Future<void> getStartedQuiz() async {
    if (quizQuestionSelectedValues.isEmpty) {
      if (CacheHelper.sharedPreferences.get('isQuizStarted') != null &&
          CacheHelper.sharedPreferences.get('isQuizStarted') == 'true') {
        String storedJsonString = CacheHelper.sharedPreferences
                .getString('quizQuestionSelectedValuesList') ??
            '';
        List<dynamic> retrievedList = jsonDecode(storedJsonString);
        List<int> typedList = retrievedList.cast<int>();

        print(typedList);
        for (var element in typedList) {
          quizQuestionSelectedValues
              .addAll({typedList.indexOf(element): element.toInt()});
        }
        print(quizQuestionSelectedValues);
        // isQuizLast == 'true' ? quizQuestionSelectedValues = quizValues : quizQuestionSelectedValues;
        emit(AppChangeLocalState());
      }
    }
  }

  int convertTimeStringToComponents(String timeString) {
    // Parse the time string into hours, minutes, and seconds
    List<String> timeParts = timeString.split(':');

    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);

    // Calculate the total number of seconds
    int totalSeconds = (hours * 3600) + (minutes * 60) + seconds;
    return totalSeconds;
  }

  changeLanguageValue(context) async {
    delegate.changeLocale(delegate.currentLocale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar'));
    emit(AppChangeLocalState());
  }


}
