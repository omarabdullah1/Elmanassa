import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../../main.dart';
import '../../styles/colors.dart';
import '../../widget/custom_elevation.dart';
import '../../widget/dynamicFormField.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit()
        ..getLevels()
        ..changeLang(() => delegate.changeLocale(const Locale('ar'))),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) async {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          if (state is StudentRegisterSuccessState) {
            if (globalCubit.studentRegisterModel!.status == 200) {
              CacheHelper.saveDataSharedPreference(
                key: 'id',
                value: globalCubit.studentRegisterModel!.user!.id,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'token',
                value: globalCubit.studentRegisterModel!.user!.tokenData!.accessToken,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'first_name',
                value: globalCubit.studentRegisterModel!.user!.firstName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'last_name',
                value: globalCubit.studentRegisterModel!.user!.lastName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'code',
                value: globalCubit.studentRegisterModel!.user!.code!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'isParent',
                value: globalCubit.isParentRegister,
              );
              globalCubit.loginModel = null;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/student_home',
                (route) => false,
              );
            }
          } else if (state is ParentRegisterSuccessState) {
            if (globalCubit.parentRegisterModel!.status == 200) {
              CacheHelper.saveDataSharedPreference(
                key: 'id',
                value: globalCubit.parentRegisterModel!.user!.id,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'token',
                value: globalCubit
                    .parentRegisterModel!.user!.tokenData!.accessToken,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'first_name',
                value: globalCubit.parentRegisterModel!.user!.firstName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'last_name',
                value: globalCubit.parentRegisterModel!.user!.lastName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'isParent',
                value: globalCubit.isParentRegister,
              );
              globalCubit.loginModel = null;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/parent_home',
                (route) => false,
              );
            }
          }
        },
        builder: (context, state) {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          return Scaffold(
            backgroundColor: AppColor.babyBlue,
            body: state is GetLevelsLoadingState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.indigoDye,
                    ),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05,
                          right: MediaQuery.of(context).size.width * 0.85,
                          child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: CustomElevation(
                              color: AppColor.roseMadder,
                              opacity: 0.4,
                              radius: 10.0,
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/entry',
                                    (route) => false,
                                  );
                                },
                                backgroundColor: AppColor.white,
                                mini: true,
                                elevation: 1,
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 25.0,
                                  color: AppColor.roseMadder,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).viewInsets.bottom == 0
                              ? MediaQuery.of(context).size.height * 0.0
                              : MediaQuery.of(context).size.height * 0.0,
                          left: 0.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                                MediaQuery.of(context).viewInsets.bottom == 0
                                    ? MediaQuery.of(context).size.height * 0.80
                                    : MediaQuery.of(context).size.height * 0.45,
                            decoration: const BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.08,
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom == 0
                                    ? MediaQuery.of(context).size.height * 0.27
                                    : MediaQuery.of(context).size.height * 0.27,
                            width: MediaQuery.of(context).size.width,
                            child: const CircleAvatar(
                              backgroundColor: AppColor.babyBlue,
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.09,
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom == 0
                                    ? MediaQuery.of(context).size.height * 0.26
                                    : MediaQuery.of(context).size.height * 0.26,
                            width: MediaQuery.of(context).size.width,
                            child: const Image(
                              image: AssetImage(
                                'assets/images/person.png',
                              ),
                            ),
                          ),
                        ),
                        globalCubit.isParentRegister
                            ? Positioned(
                                bottom: 0.0,
                                height: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom ==
                                        0
                                    ? MediaQuery.of(context).size.height * 0.63
                                    : MediaQuery.of(context).size.height * 0.30,
                                child: SingleChildScrollView(
                                  child: Builder(builder: (context) {
                                    return SizedBox(
                                      height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom ==
                                              0
                                          ? MediaQuery.of(context).size.height *
                                              0.63
                                          : MediaQuery.of(context).size.height *
                                              0.30,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Form(
                                            key: formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'ولي أمر جديد',
                                                  style: TextStyle(
                                                    fontFamily: 'cairo',
                                                    color: AppColor.indigoDye,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        pFirstNameController,
                                                    type: TextInputType.text,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourFullName',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: 'الإسم الأول',
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix:
                                                        Icons.person_rounded,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        pSecondNameController,
                                                    type: TextInputType.text,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourFullName',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: 'الإسم الأخير',
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix:
                                                        Icons.person_rounded,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40.0,
                                                  ),
                                                  child: dynamicFormField(
                                                    controller:
                                                        pEmailController,
                                                    type: TextInputType
                                                        .emailAddress,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourEmailAddress',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate('email')
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix:
                                                        Icons.email_outlined,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        pPhoneController,
                                                    type: TextInputType.phone,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPhone',
                                                            )
                                                            .toString();
                                                      } else if (value.length <
                                                              11 ||
                                                          value.length > 15) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                                'phoneWrong')
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate('phone')
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.phone_android,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        pPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffix,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    isPassword:
                                                        globalCubit.isPassword,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordVisibility();
                                                    },
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPassword',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate('password')
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.lock_outline,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40.0,
                                                  ),
                                                  child: dynamicFormField(
                                                    controller:
                                                        pConfirmPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffix,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    onSubmit: (value) {
                                                      // if (formKey.currentState!
                                                      //     .validate()) {
                                                      //   globalCubit
                                                      //       .userRegister(
                                                      //     email: emailController.text,
                                                      //     password:
                                                      //         passwordController.text,
                                                      //     fname:
                                                      //         firstNameController.text,
                                                      //     sname:
                                                      //         secondNameController.text,
                                                      //     phone: phoneController.text,
                                                      //     context: context,
                                                      //   );
                                                      // }
                                                    },
                                                    isPassword:
                                                        globalCubit.isPassword,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordVisibility();
                                                    },
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPassword',
                                                            )
                                                            .toString();
                                                      } else if (pPasswordController
                                                              .text !=
                                                          value) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'passwordNotMatch',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                          'confirmPassword',
                                                        )
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.lock_outline,
                                                  ),
                                                ),
                                                // const Expanded(
                                                //   child: SizedBox(),
                                                // ),
                                                const SizedBox(
                                                  height: 35.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40.0,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        const FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Text(
                                                            'كود الطالب',
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .babyBlue,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'cairo',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        globalCubit.qrList
                                                                .isNotEmpty
                                                            ? SizedBox(
                                                                width: 120.0,
                                                                height: 35.0,
                                                                child: ListView
                                                                    .separated(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemBuilder: (context,
                                                                          index) =>
                                                                      Container(
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        35.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColor
                                                                          .indigoDye,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        20.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        right:
                                                                            8.0,
                                                                      ),
                                                                      child:
                                                                          FittedBox(
                                                                        fit: BoxFit
                                                                            .scaleDown,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              globalCubit.qrList[index],
                                                                              style: const TextStyle(
                                                                                color: AppColor.white,
                                                                                fontSize: 18,
                                                                                fontFamily: 'cairo',
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 15.0,
                                                                            ),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  globalCubit.qrList.remove(globalCubit.qrList[index]);
                                                                                  globalCubit.removeQrUpdateState();
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.close,
                                                                                  color: AppColor.white,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  separatorBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  itemCount:
                                                                      globalCubit
                                                                          .qrList
                                                                          .length,
                                                                ),
                                                              )
                                                            : const SizedBox(
                                                                width: 120.0,
                                                                height: 40.0,
                                                              ),
                                                        const SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        // const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CustomElevation(
                                                            color: AppColor
                                                                .roseMadder,
                                                            radius: 8.0,
                                                            opacity: 0.8,
                                                            child: SizedBox(
                                                              height: 35.0,
                                                              width: 80.0,
                                                              child:
                                                                  MaterialButton(
                                                                // height: 35.0,
                                                                elevation: 5.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    8.0,
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  globalCubit
                                                                      .qrCode();
                                                                },
                                                                color: AppColor
                                                                    .roseMadder,
                                                                child:
                                                                    const FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  child: Text(
                                                                    'مسح الرمز',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'cairo',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: Container(
                                                    height: 4.0,
                                                    width: double.infinity,
                                                    color: AppColor.indigoDye,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                          horizontal: 28.0,
                                                        ),
                                                        child: Text(
                                                          (globalCubit.qrList.isEmpty)
                                                              ? '*برجاء مسح الرمز'
                                                              : '',
                                                          style:
                                                          const TextStyle(
                                                            color: AppColor
                                                                .roseMadder,
                                                            fontSize: 14.0,
                                                            fontFamily: 'cairo',
                                                            fontWeight:
                                                            FontWeight.w100,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 40.0,
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    underline: Container(
                                                      color: AppColor.indigoDye,
                                                      height: 10.0,
                                                    ),
                                                    isExpanded: false,
                                                    // hint: const Text(
                                                    //   'اختر النوع',
                                                    //   style: TextStyle(
                                                    //     color: AppColor.babyBlue,
                                                    //     fontSize: 18,
                                                    //     fontFamily: 'cairo',
                                                    //     fontWeight:
                                                    //     FontWeight.w700,
                                                    //   ),
                                                    // ),
                                                    items: globalCubit
                                                        .genderList
                                                        .map((String item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style:
                                                                    const TextStyle(
                                                                  color: AppColor
                                                                      .babyBlue,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'cairo',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    value: globalCubit
                                                            .selectedGender ??
                                                        '',
                                                    onChanged: (String? value) {
                                                      globalCubit
                                                              .selectedGender =
                                                          value!;
                                                      globalCubit
                                                          .changeLocalState();
                                                    },
                                                    buttonStyleData:
                                                        const ButtonStyleData(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 40.0,
                                                      ),
                                                      height: 40,
                                                      width: double.infinity,
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 40,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: Container(
                                                    height: 4.0,
                                                    width: double.infinity,
                                                    color: AppColor.indigoDye,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 28.0,
                                                        ),
                                                        child: Text(
                                                          (globalCubit.selectedGender ==
                                                                  'اختر النوع')
                                                              ? '*برجاء اختيار النوع'
                                                              : '',
                                                          style:
                                                              const TextStyle(
                                                            color: AppColor
                                                                .roseMadder,
                                                            fontSize: 14.0,
                                                            fontFamily: 'cairo',
                                                            fontWeight:
                                                                FontWeight.w100,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40.0,
                                                ),
                                                ConditionalBuilder(
                                                  condition: state
                                                      is! ParentRegisterLoadingState,
                                                  fallback: (context) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                    color: AppColor.honeyYellow,
                                                  )),
                                                  builder: (context) =>
                                                      CustomElevation(
                                                    color: AppColor.honeyYellow,
                                                    radius: 21.0,
                                                    opacity: 0.8,
                                                    child: MaterialButton(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              17.0,
                                                      minWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      elevation: 5.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          21.0,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        if (formKey
                                                                .currentState!
                                                                .validate() &&
                                                            globalCubit
                                                                    .selectedGender !=
                                                                'اختر النوع' &&
                                                            globalCubit.qrList
                                                                .isNotEmpty) {
                                                          globalCubit
                                                              .parentRegister(
                                                            email:
                                                                pEmailController
                                                                    .text,
                                                            password:
                                                                pPasswordController
                                                                    .text,
                                                            firstName:
                                                                pFirstNameController
                                                                    .text,
                                                            secondName:
                                                                pSecondNameController
                                                                    .text,
                                                            phone:
                                                                pPhoneController
                                                                    .text,
                                                            gender: globalCubit
                                                                .selectedGender
                                                                .toString(),
                                                            studentsCodes:
                                                                globalCubit
                                                                    .qrList,
                                                            context: context,
                                                          );
                                                        }
                                                      },
                                                      color:
                                                          AppColor.honeyYellow,
                                                      child: const Text(
                                                        'أستمرار',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontFamily: 'cairo',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: 200.0,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.roseMadder,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () => globalCubit
                                                            .changeIsParentRegisterValue(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 45,
                                                            width: 83.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: globalCubit
                                                                      .isParentRegister
                                                                  ? AppColor
                                                                      .white
                                                                  : AppColor
                                                                      .roseMadder,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'ولي أمر',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'cairo',
                                                                  color: globalCubit.isParentRegister
                                                                      ? AppColor
                                                                          .indigoDye
                                                                      : AppColor
                                                                          .white,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: () => globalCubit
                                                            .changeIsParentRegisterValue(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 45,
                                                            width: 83.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: !globalCubit
                                                                      .isParentRegister
                                                                  ? AppColor
                                                                      .white
                                                                  : AppColor
                                                                      .roseMadder,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'طالب',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'cairo',
                                                                  color: !globalCubit.isParentRegister
                                                                      ? AppColor
                                                                          .indigoDye
                                                                      : AppColor
                                                                          .white,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              )
                            : Positioned(
                                bottom: 0.0,
                                height: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom ==
                                        0
                                    ? MediaQuery.of(context).size.height * 0.63
                                    : MediaQuery.of(context).size.height * 0.30,
                                child: SingleChildScrollView(
                                  child: Builder(builder: (context) {
                                    return SizedBox(
                                      height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom ==
                                              0
                                          ? MediaQuery.of(context).size.height *
                                              0.63
                                          : MediaQuery.of(context).size.height *
                                              0.30,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Form(
                                            key: formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'طالب جديد',
                                                  style: TextStyle(
                                                    fontFamily: 'cairo',
                                                    color: AppColor.indigoDye,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        sFirstNameController,
                                                    type: TextInputType.text,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourFullName',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: 'الإسم الأول',
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix:
                                                        Icons.person_rounded,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        sSecondNameController,
                                                    type: TextInputType.text,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourFullName',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: 'الإسم الأخير',
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix:
                                                        Icons.person_rounded,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40.0,
                                                  ),
                                                  child: dynamicFormField(
                                                    controller:
                                                        sEmailController,
                                                    type: TextInputType
                                                        .emailAddress,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourEmailAddress',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate('email')
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix:
                                                        Icons.email_outlined,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        sPhoneController,
                                                    type: TextInputType.phone,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPhone',
                                                            )
                                                            .toString();
                                                      } else if (value.length <
                                                              11 ||
                                                          value.length > 15) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                                'phoneWrong')
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate('phone')
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.phone_android,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        sPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffix,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    isPassword:
                                                        globalCubit.isPassword,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordVisibility();
                                                    },
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPassword',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate('password')
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.lock_outline,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller:
                                                        sConfirmPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffix,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    onSubmit: (value) {
                                                      // if (formKey.currentState!
                                                      //     .validate()) {
                                                      //   globalCubit
                                                      //       .userRegister(
                                                      //     email: sEmailController
                                                      //         .text,
                                                      //     password:
                                                      //         sPasswordController
                                                      //             .text,
                                                      //     fname:
                                                      //         sFirstNameController
                                                      //             .text,
                                                      //     sname:
                                                      //         sSecondNameController
                                                      //             .text,
                                                      //     phone: sPhoneController
                                                      //         .text,
                                                      //     context: context,
                                                      //   );
                                                      // }
                                                    },
                                                    isPassword:
                                                        globalCubit.isPassword,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordVisibility();
                                                    },
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPassword',
                                                            )
                                                            .toString();
                                                      } else if (sPasswordController
                                                              .text !=
                                                          value) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'passwordNotMatch',
                                                            )
                                                            .toString();
                                                      }
                                                    },
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                          'confirmPassword',
                                                        )
                                                        .toString(),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.lock_outline,
                                                  ),
                                                ),
                                                // const Expanded(
                                                //   child: SizedBox(),
                                                // ),
                                                const SizedBox(
                                                  height: 40.0,
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    underline: Container(
                                                      color: AppColor.indigoDye,
                                                      height: 10.0,
                                                    ),
                                                    isExpanded: false,
                                                    // hint: const Text(
                                                    //   'اختر النوع',
                                                    //   style: TextStyle(
                                                    //     color: AppColor.babyBlue,
                                                    //     fontSize: 18,
                                                    //     fontFamily: 'cairo',
                                                    //     fontWeight:
                                                    //     FontWeight.w700,
                                                    //   ),
                                                    // ),
                                                    items: globalCubit
                                                        .genderList
                                                        .map((String item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style:
                                                                    const TextStyle(
                                                                  color: AppColor
                                                                      .babyBlue,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'cairo',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    value: globalCubit
                                                            .selectedGender ??
                                                        '',
                                                    onChanged: (String? value) {
                                                      globalCubit
                                                              .selectedGender =
                                                          value!;
                                                      globalCubit
                                                          .changeLocalState();
                                                    },
                                                    buttonStyleData:
                                                        const ButtonStyleData(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 40.0,
                                                      ),
                                                      height: 40,
                                                      width: double.infinity,
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 40,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: Container(
                                                    height: 4.0,
                                                    width: double.infinity,
                                                    color: AppColor.indigoDye,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 28.0,
                                                        ),
                                                        child: Text(
                                                          (globalCubit.selectedGender ==
                                                                  'اختر النوع')
                                                              ? '*برجاء اختيار النوع'
                                                              : '',
                                                          style:
                                                              const TextStyle(
                                                            color: AppColor
                                                                .roseMadder,
                                                            fontSize: 14.0,
                                                            fontFamily: 'cairo',
                                                            fontWeight:
                                                                FontWeight.w100,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    underline: Container(
                                                      color: AppColor.indigoDye,
                                                      height: 10.0,
                                                    ),
                                                    isExpanded: false,
                                                    hint: const Text(
                                                      'اختر المستوي',
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.babyBlue,
                                                        fontSize: 18,
                                                        fontFamily: 'cairo',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    items: globalCubit
                                                        .allLevelsTitle
                                                        .map((String item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style:
                                                                    const TextStyle(
                                                                  color: AppColor
                                                                      .babyBlue,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'cairo',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    value: globalCubit
                                                        .selectedLevel,
                                                    onChanged: (String? value) {
                                                      globalCubit
                                                              .selectedLevel =
                                                          value;
                                                      globalCubit
                                                          .changeLocalState();
                                                    },
                                                    buttonStyleData:
                                                        const ButtonStyleData(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 40.0,
                                                      ),
                                                      height: 40,
                                                      width: double.infinity,
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 40,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: Container(
                                                    height: 4.0,
                                                    width: double.infinity,
                                                    color: AppColor.indigoDye,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 28.0,
                                                        ),
                                                        child: Text(
                                                          (globalCubit.selectedLevel ==
                                                                  'اختر المستوي')
                                                              ? '*برجاء اختيار المستوي'
                                                              : '',
                                                          style:
                                                              const TextStyle(
                                                            color: AppColor
                                                                .roseMadder,
                                                            fontSize: 14.0,
                                                            fontFamily: 'cairo',
                                                            fontWeight:
                                                                FontWeight.w100,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                ConditionalBuilder(
                                                  condition: state
                                                      is! StudentRegisterLoadingState,
                                                  fallback: (context) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                    color: AppColor.honeyYellow,
                                                  )),
                                                  builder: (context) =>
                                                      CustomElevation(
                                                    color: AppColor.honeyYellow,
                                                    radius: 21.0,
                                                    opacity: 0.8,
                                                    child: MaterialButton(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              17.0,
                                                      minWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      elevation: 5.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          21.0,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        if (formKey
                                                                .currentState!
                                                                .validate() &&
                                                            globalCubit
                                                                    .selectedLevel !=
                                                                'اختر المستوي' &&
                                                            globalCubit
                                                                    .selectedGender !=
                                                                'اختر النوع') {
                                                          globalCubit
                                                              .userRegister(
                                                            email:
                                                                sEmailController
                                                                    .text,
                                                            password:
                                                                sPasswordController
                                                                    .text,
                                                            firstName:
                                                                sFirstNameController
                                                                    .text,
                                                            secondName:
                                                                sSecondNameController
                                                                    .text,
                                                            phone:
                                                                sPhoneController
                                                                    .text,
                                                            gender: globalCubit
                                                                .selectedGender
                                                                .toString(),
                                                            context: context,
                                                          );
                                                        }
                                                      },
                                                      color:
                                                          AppColor.honeyYellow,
                                                      child: const Text(
                                                        'أستمرار',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontFamily: 'cairo',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: 200.0,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.roseMadder,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () => globalCubit
                                                            .changeIsParentRegisterValue(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 45,
                                                            width: 83.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: globalCubit
                                                                      .isParentRegister
                                                                  ? AppColor
                                                                      .white
                                                                  : AppColor
                                                                      .roseMadder,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'ولي أمر',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'cairo',
                                                                  color: globalCubit.isParentRegister
                                                                      ? AppColor
                                                                          .indigoDye
                                                                      : AppColor
                                                                          .white,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: () => globalCubit
                                                            .changeIsParentRegisterValue(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 45,
                                                            width: 83.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: !globalCubit
                                                                      .isParentRegister
                                                                  ? AppColor
                                                                      .white
                                                                  : AppColor
                                                                      .roseMadder,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'طالب',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'cairo',
                                                                  color: !globalCubit.isParentRegister
                                                                      ? AppColor
                                                                          .indigoDye
                                                                      : AppColor
                                                                          .white,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path p = getPath();

    Rect b = p.getBounds();
    var pathWidth = b.width;
    var pathHeight = b.height;
    var screenWidth = size.width;
    var screenHeight = size.height;
    var xScale = screenWidth / pathWidth;
    var yScale = screenHeight / pathHeight;

    //UNCOMMENT the following line to see the scaling effect
    canvas.scale(xScale * 0.6, yScale * 0.8);

    // canvas.drawPath(p, Paint()
    //   ..color = Colors.red);
    Path path_0 = Path();
    path_0.moveTo(179, 123.793);
    path_0.cubicTo(236.438, 123.793, 283, 75.0845, 283, 15);
    path_0.lineTo(320, 15);
    path_0.cubicTo(342.091, 15, 360, 32.9086, 360, 55);
    path_0.lineTo(360, 696);
    path_0.lineTo(0, 696);
    path_0.lineTo(0, 55);
    path_0.cubicTo(0, 32.9086, 17.9086, 15, 40, 15);
    path_0.lineTo(75, 15);
    path_0.cubicTo(75, 75.0845, 121.562, 123.793, 179, 123.793);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  Path getPath() {
    Path p = Path();
    double w = 100;
    double h = 100;
    p.moveTo(0, 0);
    p.lineTo(0, h);
    p.lineTo(w, h);
    p.lineTo(w, 0);
    p.close();
    return p;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
