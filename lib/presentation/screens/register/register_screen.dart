import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../../constants/screens.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';
import '../../widget/back_button.dart';
import '../../widget/custom_elevation.dart';
import '../../widget/dynamic_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit()..getLevels(),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) async {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          if (state is StudentRegisterSuccessState) {
            if (globalCubit.studentRegisterModel!.status == 200) {
              CacheHelper.saveDataSharedPreference(
                key: 'id',
                value: globalCubit.studentRegisterModel!.userData!.user!.id,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'token',
                value: globalCubit.studentRegisterModel!.userData!.token,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'first_name',
                value: globalCubit
                    .studentRegisterModel!.userData!.user!.firstName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'last_name',
                value:
                    globalCubit.studentRegisterModel!.userData!.user!.lastName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'code',
                value: globalCubit.studentRegisterModel!.userData!.user!.code!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'isParent',
                value: globalCubit.isParentRegister,
              );
              globalCubit.loginModel = null;
              Navigator.pushNamedAndRemoveUntil(
                context,
                Screens.studentHomeScreen,
                (route) => false,
              );
            }
          } else if (state is ParentRegisterSuccessState) {
            if (globalCubit.parentRegisterModel!.status == 200) {
              CacheHelper.saveDataSharedPreference(
                key: 'id',
                value: globalCubit.parentRegisterModel!.data!.user!.id,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'token',
                value: globalCubit.parentRegisterModel!.data!.token,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'first_name',
                value: globalCubit.parentRegisterModel!.data!.user!.firstName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'last_name',
                value: globalCubit.parentRegisterModel!.data!.user!.lastName!,
              );
              CacheHelper.saveDataSharedPreference(
                key: 'isParent',
                value: globalCubit.isParentRegister,
              );
              globalCubit.loginModel = null;
              Navigator.pushNamedAndRemoveUntil(
                context,
                Screens.parentHomeScreen,
                (route) => false,
              );
            }
          }
        },
        builder: (context, state) {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          return Scaffold(
            backgroundColor: AppColor.babyBlue,
            appBar: AppBar(
              leading: BackButtonWidget(
                direction: delegate.currentLocale == 'ar' ? false : true,
              ),
              backgroundColor: AppColor.babyBlue,
            ),
            body: state is GetLevelsLoadingState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.indigoDye,
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      double height = constraints.maxHeight;
                      return SingleChildScrollView(
                        child: SizedBox(
                          width: width,
                          height: globalCubit.isParentRegister
                              ? height * 1.450
                              : height * 1.350,
                          child: Stack(
                            children: [
                              Positioned(
                                top: MediaQuery.of(context).viewInsets.bottom ==
                                        0
                                    ? 100.0
                                    : 100.0,
                                child: Container(
                                  width: width,
                                  height: globalCubit.isParentRegister
                                      ? height * 1.350
                                      : height * 1.350,
                                  decoration: const BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: globalCubit.isParentRegister
                                          ? 0.0
                                          : height * 0.1,
                                    ),
                                    child: globalCubit.isParentRegister
                                        ? Form(
                                            key: globalCubit.registerFormKey,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  Texts.translate(
                                                      Texts
                                                          .registerNewParentText,
                                                      context),
                                                  style: TextStyles
                                                      .registerNewParentStyle,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40.0),
                                                  child: dynamicFormField(
                                                    controller: globalCubit
                                                        .pFirstNameController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerFirstNameLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .pSecondNameController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerLastNameLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .pEmailController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerEmailLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .pPhoneController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerPhoneLabel,
                                                        context),
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
                                                    horizontal: 40.0,
                                                  ),
                                                  child: dynamicFormField(
                                                    controller: globalCubit
                                                        .pPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffixOne,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    isPassword: globalCubit
                                                        .isPasswordOne,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordOneVisibility();
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerPasswordLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .pConfirmPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffixTwo,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    onSubmit: (value) {},
                                                    isPassword: globalCubit
                                                        .isPasswordTwo,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordTwoVisibility();
                                                    },
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPassword',
                                                            )
                                                            .toString();
                                                      } else if (globalCubit
                                                              .pPasswordController
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerConfirmPasswordLabel,
                                                        context),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.lock_outline,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
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
                                                        FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Text(
                                                            Texts.translate(
                                                                Texts
                                                                    .registerStudentCode,
                                                                context),
                                                            style: TextStyles
                                                                .registerStudentCodeStyle,
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
                                                                              style: TextStyles.registerQrCodeStyle,
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
                                                                  // globalCubit
                                                                  //     .qrList.add(globalCubit.qrList[0].toString());
                                                                },
                                                                color: AppColor
                                                                    .roseMadder,
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  child: Text(
                                                                    Texts.translate(
                                                                        Texts
                                                                            .registerScanCode,
                                                                        context),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyles
                                                                        .registerScanCodeStyle,
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
                                                    horizontal: 40.0,
                                                  ),
                                                  child: Container(
                                                    height: 4.0,
                                                    width: double.infinity,
                                                    color: AppColor.indigoDye,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 28.0,
                                                        ),
                                                        child: Text(
                                                          (globalCubit.qrList
                                                                  .isEmpty)
                                                              ? Texts.translate(
                                                                  Texts
                                                                      .registerPleaseScanCodeText,
                                                                  context)
                                                              : '',
                                                          style: TextStyles
                                                              .registerPleaseScanCodeStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
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
                                                                style: TextStyles
                                                                    .registerGenderListItemStyle,
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
                                                    horizontal: 40.0,
                                                  ),
                                                  child: Container(
                                                    height: 4.0,
                                                    width: double.infinity,
                                                    color: AppColor.indigoDye,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
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
                                                                  Texts.translate(
                                                                      Texts
                                                                          .registerSelectGenderText,
                                                                      context))
                                                              ? Texts.translate(
                                                                  Texts
                                                                      .registerPleaseSelectGenderText,
                                                                  context)
                                                              : '',
                                                          style: TextStyles
                                                              .registerPleaseSelectGenderStyle,
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
                                                        if (globalCubit
                                                                .registerFormKey
                                                                .currentState!
                                                                .validate() &&
                                                            globalCubit
                                                                    .selectedGender !=
                                                                Texts.translate(
                                                                    Texts
                                                                        .registerSelectGenderText,
                                                                    context) &&
                                                            globalCubit.qrList
                                                                .isNotEmpty) {
                                                          globalCubit
                                                              .parentRegister(
                                                            email: globalCubit
                                                                .pEmailController
                                                                .text,
                                                            password: globalCubit
                                                                .pPasswordController
                                                                .text,
                                                            firstName: globalCubit
                                                                .pFirstNameController
                                                                .text,
                                                            secondName: globalCubit
                                                                .pSecondNameController
                                                                .text,
                                                            phone: globalCubit
                                                                .pPhoneController
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
                                                      child: Text(
                                                        Texts.translate(
                                                            Texts.continueText,
                                                            context),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyles
                                                            .continueTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: Container(
                                                    height: 45,
                                                    width: 200.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColor.roseMadder,
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
                                                                  Texts.translate(
                                                                      Texts
                                                                          .parentText,
                                                                      context),
                                                                  style: TextStyles
                                                                      .studentStyle(
                                                                    !globalCubit
                                                                        .isParentRegister,
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
                                                                  Texts.translate(
                                                                      Texts
                                                                          .studentText,
                                                                      context),
                                                                  style: TextStyles
                                                                      .studentStyle(
                                                                    globalCubit
                                                                        .isParentRegister,
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
                                              ],
                                            ),
                                          )
                                        : Form(
                                            key: globalCubit.registerFormKey,
                                            child: Column(
                                              children: [
                                                Text(
                                                  Texts.translate(
                                                      Texts
                                                          .registerNewStudentText,
                                                      context),
                                                  style: TextStyles
                                                      .registerNewStudentStyle,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40.0,
                                                  ),
                                                  child: dynamicFormField(
                                                    controller: globalCubit
                                                        .sFirstNameController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerFirstNameLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .sSecondNameController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerLastNameLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .sEmailController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerEmailLabel,
                                                        context),
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
                                                    horizontal: 40.0,
                                                  ),
                                                  child: dynamicFormField(
                                                    controller: globalCubit
                                                        .sPhoneController,
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerPhoneLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .sPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffixOne,
                                                    isValidate: true,
                                                    isLabel: true,
                                                    borderRadius: 10,
                                                    isPassword: globalCubit
                                                        .isPasswordOne,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordOneVisibility();
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerPasswordLabel,
                                                        context),
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
                                                    controller: globalCubit
                                                        .sConfirmPasswordController,
                                                    type: TextInputType
                                                        .visiblePassword,
                                                    suffixIcon:
                                                        globalCubit.suffixTwo,
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
                                                    isPassword: globalCubit
                                                        .isPasswordTwo,
                                                    suffixPressed: () {
                                                      globalCubit
                                                          .changePasswordTwoVisibility();
                                                    },
                                                    validate: (String value) {
                                                      if (value.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .translate(
                                                              'pleaseEnterYourPassword',
                                                            )
                                                            .toString();
                                                      } else if (globalCubit
                                                              .sPasswordController
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
                                                    label: Texts.translate(
                                                        Texts
                                                            .registerConfirmPasswordLabel,
                                                        context),
                                                    labelColor:
                                                        AppColor.babyBlue,
                                                    prefix: Icons.lock_outline,
                                                  ),
                                                ),
                                                // const Expanded(
                                                //   child: SizedBox(),
                                                // ),
                                                const SizedBox(
                                                  height: 10.0,
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
                                                                style: TextStyles
                                                                    .registerGenderListItemStyle,
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
                                                    horizontal: 40.0,
                                                  ),
                                                  child: Container(
                                                    height: 4.0,
                                                    width: double.infinity,
                                                    color: AppColor.indigoDye,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        (globalCubit.selectedGender ==
                                                                Texts.translate(
                                                                    Texts
                                                                        .registerSelectGenderText,
                                                                    context))
                                                            ? Texts.translate(
                                                                Texts
                                                                    .registerPleaseSelectGenderText,
                                                                context)
                                                            : '',
                                                        style: TextStyles
                                                            .registerPleaseSelectGenderStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    underline: Container(
                                                      color: AppColor.indigoDye,
                                                      height: 10.0,
                                                    ),
                                                    isExpanded: false,
                                                    hint: Text(
                                                      Texts.translate(
                                                          Texts
                                                              .registerSelectLevelText,
                                                          context),
                                                      style: TextStyles
                                                          .registerSelectLevelStyle,
                                                    ),
                                                    items: globalCubit
                                                        .allLevelsTitle
                                                        .map((String item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style: TextStyles
                                                                    .registerLevelsListItemStyle,
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
                                                                  Texts.translate(
                                                                      Texts
                                                                          .registerSelectLevelText,
                                                                      context))
                                                              ? Texts.translate(
                                                                  Texts
                                                                      .registerPleaseSelectLevelText,
                                                                  context)
                                                              : '',
                                                          style: TextStyles
                                                              .registerPleaseSelectLevelStyle,
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
                                                        if (globalCubit
                                                                .registerFormKey
                                                                .currentState!
                                                                .validate() &&
                                                            globalCubit
                                                                    .selectedLevel !=
                                                                Texts.translate(
                                                                    Texts
                                                                        .registerSelectLevelText,
                                                                    context) &&
                                                            globalCubit
                                                                    .selectedGender !=
                                                                Texts.translate(
                                                                    Texts
                                                                        .registerSelectGenderText,
                                                                    context)) {
                                                          globalCubit
                                                              .userRegister(
                                                            email: globalCubit
                                                                .sEmailController
                                                                .text,
                                                            password: globalCubit
                                                                .sPasswordController
                                                                .text,
                                                            firstName: globalCubit
                                                                .sFirstNameController
                                                                .text,
                                                            secondName: globalCubit
                                                                .sSecondNameController
                                                                .text,
                                                            phone: globalCubit
                                                                .sPhoneController
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
                                                      child: Text(
                                                        Texts.translate(
                                                            Texts.continueText,
                                                            context),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
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
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Container(
                                                    height: 45,
                                                    width: 200.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColor.roseMadder,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        25.0,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () => globalCubit
                                                              .changeIsParentRegisterValue(),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                              8.0,
                                                            ),
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
                                                                  25.0,
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  Texts.translate(
                                                                      Texts
                                                                          .parentText,
                                                                      context),
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
                                                                    .all(
                                                              8.0,
                                                            ),
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
                                                                  25.0,
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  Texts.translate(
                                                                      Texts
                                                                          .studentText,
                                                                      context),
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
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -8.0,
                                child: SizedBox(
                                  height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom ==
                                          0
                                      ? MediaQuery.of(context).size.height *
                                          0.208
                                      : MediaQuery.of(context).size.height *
                                          0.208,
                                  width: MediaQuery.of(context).size.width,
                                  child: const CircleAvatar(
                                    backgroundColor: AppColor.babyBlue,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                child: SizedBox(
                                  height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom ==
                                          0
                                      ? MediaQuery.of(context).size.height *
                                          0.20
                                      : MediaQuery.of(context).size.height *
                                          0.20,
                                  width: MediaQuery.of(context).size.width,
                                  child: const Image(
                                    image: AssetImage(
                                      Assets.iconImgPerson,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
