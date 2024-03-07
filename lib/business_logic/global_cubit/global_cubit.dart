import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/end_points.dart';
import '../../data/local/cache_helper.dart';
import '../../data/models/account_model.dart';
import '../../data/models/levels_model.dart';
import '../../data/models/parent_model.dart';
import '../../data/models/parent_register_model.dart';
import '../../data/models/student_register_model.dart';
import '../../data/remote/dio_helper.dart';
import '../../main.dart';
import '../../presentation/widget/toast.dart';
import '../app_localization.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final sFirstNameController = TextEditingController();

  final sSecondNameController = TextEditingController();

  final sEmailController = TextEditingController();

  final sPhoneController = TextEditingController();

  final sPasswordController = TextEditingController();

  final sConfirmPasswordController = TextEditingController();

  final pFirstNameController = TextEditingController();

  final pSecondNameController = TextEditingController();

  final pEmailController = TextEditingController();

  final pPhoneController = TextEditingController();

  final pPasswordController = TextEditingController();

  final pConfirmPasswordController = TextEditingController();

  final pStudentCodeController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  AccountModel? loginModel;
  ParentModel? parentModel;
  StudentRegisterModel? studentRegisterModel;
  ParentRegisterModel? parentRegisterModel;
  LevelsModel? levelsModel;

  bool isEnglish = CacheHelper.getDataFromSharedPreference(key: 'lang') == 'en'
      ? true
      : false;
  bool isParentLogin = false;
  bool isParentRegister = false;
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
  List<String> qrList = [];

  // final List<String>? allLevelsTitle=['sss','sss'];
  List<String>? allLevelsId = [];

  void userLogin(
      {required String email, required String password, required context}) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: userLoginPath,
      body: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      log(value.data.toString());
      loginModel = AccountModel.fromJson(value.data);
      log(loginModel!.userData!.user!.firstName.toString());
      fToast.init(context);
      showToast(AppLocalizations.of(context)!
          .translate('loginSuccessfully')
          .toString());
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      log(error.toString());
      fToast.init(context);
      showToast(AppLocalizations.of(context)!
          .translate('pleaseCheckUsernameAndPassword')
          .toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  void parentLogin({
    required String email,
    required String password,
    required context,
  }) {
    // log("Iam heeeeeeeeeeeere");
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
      fToast.init(context);
      showToast(AppLocalizations.of(context)!
          .translate('loginSuccessfully')
          .toString());
      emit(LoginParentSuccessState(parentModel!));
    }).catchError((error) {
      log(error.toString());
      fToast.init(context);
      showToast(AppLocalizations.of(context)!
          .translate('pleaseCheckUsernameAndPassword')
          .toString());
      emit(LoginParentErrorState(error.toString()));
    });
  }

  void userRegister({
    required String firstName,
    required String secondName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    required context,
  }) {
    emit(StudentRegisterLoadingState());

    DioHelper.postData(
      url: studentRegisterPath,
      body: {
        'first_name': firstName,
        'last_name': secondName,
        'email': email,
        'password': password,
        'phone': phone,
        'gender': genderListEN[genderList.indexOf(selectedGender!)],
        'level_id': allLevelsId![allLevelsTitle.indexOf(selectedLevel!)]
      },
    ).then((value) {
      studentRegisterModel = StudentRegisterModel.fromJson(value.data);
      log(value.data.toString());
      log(studentRegisterModel!.status.toString());
      fToast.init(context);
      showToast(studentRegisterModel!.message);
      emit(StudentRegisterSuccessState());
    }).catchError((error) {
      log(error.toString());
      log(error.toString());
      fToast.init(context);
      showToast(error.toString());
      emit(StudentRegisterErrorState(error.toString()));
    });
  }

  void parentRegister({
    required String firstName,
    required String secondName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    required List<String> studentsCodes,
    required context,
  }) {
    emit(ParentRegisterLoadingState());
    log(firstName);
    log(secondName);
    log(email);
    log(password);
    log(phone);
    log(genderListEN[genderList.indexOf(selectedGender!)]);
    log(studentsCodes.toString());
    DioHelper.postData(
      url: parentRegisterPath,
      body: {
        'first_name': firstName,
        'last_name': secondName,
        'email': email,
        'password': password,
        'studentsCodes': studentsCodes,
        'phone': phone,
        'gender': genderListEN[genderList.indexOf(selectedGender!)],
      },
    ).then((value) {
      parentRegisterModel = ParentRegisterModel.fromJson(value.data);
      log(value.data.toString());
      log(parentRegisterModel!.status.toString());
      fToast.init(context);
      showToast(parentRegisterModel!.message);
      emit(ParentRegisterSuccessState());
    }).catchError((error) {
      // print(allLevelsId![allLevelsTitle.indexOf(selectedLevel!)]);
      log(error.toString());
      log(error.toString());
      fToast.init(context);
      showToast(error.toString());
      emit(ParentRegisterErrorState(error.toString()));
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
        allLevelsId!.add(element.id!.toString());
      }
      emit(GetLevelsSuccessState(levelsModel!));
    }).catchError((error) {
      log(error.toString());
      emit(GetLevelsErrorState(error.toString()));
    });
  }

  IconData suffixOne = Icons.visibility;
  IconData suffixTwo = Icons.visibility;
  bool isPasswordOne = true;
  bool isPasswordTwo = true;

  changePasswordOneVisibility() {
    isPasswordOne = !isPasswordOne;
    suffixOne = isPasswordOne ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }
  changePasswordTwoVisibility() {
    isPasswordTwo = !isPasswordTwo;
    suffixTwo = isPasswordTwo ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  changeLanguageValue(context) async {
    delegate.changeLocale(delegate.currentLocale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar'));
    emit(AppChangeLanguageState());
  }

  changeLanguageValueWithLang(context, String lang) async {
    delegate
        .changeLocale(lang == 'ar' ? const Locale('ar') : const Locale('en'));
    emit(AppChangeLanguageState());
  }

  changeIsParentLoginValue() {
    isParentLogin = !isParentLogin;
    emit(AppChangeIsParentState());
  }

  changeIsParentRegisterValue() {
    isParentRegister = !isParentRegister;
    emit(AppChangeIsParentState());
  }

  Future<void> qrCode() async {
    try {
      FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      ).then((value) {
        qrList.add(value);
        emit(AppChangeQrSuccessState());
      });

      /// barcode to be used
    } catch (e) {
      // qr = 'Unable';
      emit(AppChangeQrErrorState());
    }
  }

  removeQrUpdateState() {
    emit(AppRemoveQrState());
  }

  Future<void> changeLang(Function func) async {
    await func();
    emit(AppChangeLanguageState());
  }

  void changeLocalState() {
    emit(AppChangeLocalState());
  }

  @override
  Future<void> close() {
  passwordController.clear();
  emailController.clear();
    return super.close();
  }
}
