import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/end_points.dart';
import '../../data/local/cache_helper.dart';
import '../../data/models/parent_get_students_model.dart';
import '../../data/models/parent_model.dart';
import '../../data/models/parent_add_students_model.dart';
import '../../data/remote/dio_helper.dart';
import '../../presentation/screens/parent/home/home_screen.dart';
import '../../presentation/screens/parent/notification/notification_screen.dart';
import '../../presentation/screens/parent/profile/profile_screen.dart';
import '../../presentation/widget/toast.dart';

part 'parent_home_state.dart';

class ParentHomeCubit extends Cubit<ParentHomeState> {
  ParentHomeCubit() : super(ParentHomeInitial());

  ParentModel? parentModel;
  ParentAddStudentsModel? parentAddStudentsModel;
  ParentGetStudentsModel? parentGetStudentsModel;
  List<Widget> screens = [
    const ParentHomeScreen(),
    const ParentNotificationScreen(),
    const ParentProfileScreen(),
  ];
  int screenIndex = 0;
  String qr = '';

  void parentLogin({
    required String email,
    required String password,
  }) {
    emit(LoginParentLoadingState());

    DioHelper.postData(
      url: parentLoginPath,
      body: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // log(value.data.toString());
      parentModel = ParentModel.fromJson(value.data);
      // log(parentModel!.user!.firstName.toString());
      emit(LoginParentSuccessState(parentModel!));
    }).catchError((error) {
      log(error.toString());
      emit(LoginParentErrorState(error.toString()));
    });
  }

  Future<void> addStudent({
    required String code,
    required context,
  }) async {
    emit(AddParentStudentLoadingState());

    await DioHelper.postDataWithToken(
      url: addStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        'id': CacheHelper.sharedPreferences.get('id'),
        'code': code,
      },
    ).then((value) async {
      log(value.data.toString());
      parentAddStudentsModel = ParentAddStudentsModel.fromJson(value.data);
      log(parentAddStudentsModel!.message.toString());
      fToast.init(context);
      await showToast('ADDED SUCCESSFULLY');
      emit(AddParentStudentSuccessState());
    }).catchError((error) async {
      log(error.toString());
      // print(error.toString());
      fToast.init(context);
      await showToast(error.toString());
      emit(AddParentStudentErrorState(error.toString()));
    });
  }

  Future<void> getStudents() async {
    emit(GetParentStudentLoadingState());

    await DioHelper.postDataWithToken(
      url: getStudentPath,
      token: CacheHelper.sharedPreferences.get('token').toString(),
      body: {
        'id': CacheHelper.sharedPreferences.get('id'),
        '_method': 'GET',
      },
    ).then((value) async {
      log(value.data.toString());
      parentGetStudentsModel = ParentGetStudentsModel.fromJson(value.data);
      log(parentGetStudentsModel!.parentStudents!.first!.code.toString());
      emit(GetParentStudentSuccessState());
    }).catchError((error) async {
      log(error.toString());
      // print(error.toString());
      emit(GetParentStudentErrorState(error.toString()));
    });
  }

  changeScreenIndexState(int index) {
    screenIndex = index;
    emit(AppChangeScreenIndexState());
  }

  Future<void> qrCode() async {
    try {
      FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      ).then((value) {
        qr = value;
        emit(AppChangeQrState());
      });

      /// barcode to be used
    } catch (e) {
      qr = 'Unable';
      emit(AppChangeQrState());
    }
  }
  Future<void> changeLang(Function func) async {
    await func();
    emit(AppChangeLanguageState());
  }
}
