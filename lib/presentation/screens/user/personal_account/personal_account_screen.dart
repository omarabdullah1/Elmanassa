import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/app_localization.dart';
import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../generated/assets.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/back_button.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/dynamic_form_field.dart';

class PersonalAccountScreen extends StatelessWidget {
  const PersonalAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()..getProfileUpdateData(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          if (studentHomeCubit.profileModel != null &&
              state is! GetLevelsLoadingState) {
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              appBar: CustomAppBar(
                  appBarWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 40.0,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        Texts.translate(Texts.studentHomeProfilePageText, context),
                        style: TextStyles.studentHomeHomepageStyle,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const BackButtonWidget(),
                ],
              )),
              body: LayoutBuilder(builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 18.0,
                        ),
                        child: Container(
                          height: 90.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.roseMadder,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.indigoDye500,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppColor.black.withOpacity(0.4),
                                blurRadius: 35,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // textBaseline: TextBaseline.ideographic,
                              children: [
                                CircleAvatar(
                                  child: Image.asset(
                                    Assets.iconImgPerson,
                                    fit: BoxFit.cover,
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${studentHomeCubit.profileModel!.profile!.firstName!} ${studentHomeCubit.profileModel!.profile!.lastName!}',
                                        style: TextStyles
                                            .studentHomeProfileNameTextStyle,
                                      ),
                                      Text(
                                        studentHomeCubit.profileModel!
                                                    .profile!.role ==
                                                'student'
                                            ? Texts.translate(Texts.studentText, context)
                                            : Texts.translate(Texts.parentText, context),
                                        style: TextStyles
                                            .studentHomeProfileTypeTextStyle,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height-126.0,
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: Form(
                            key: studentHomeCubit.formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24.0,
                                      bottom: 0.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          Texts.translate(Texts.studentHomeProfilePersonalAccountDetailsText, context),
                                          style: TextStyles
                                              .studentHomeProfilePersonalAccountTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: dynamicFormField(
                                      controller:
                                      studentHomeCubit.sFirstNameController,
                                      type: TextInputType.text,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                            'pleaseEnterYourFullName',
                                          )
                                              .toString();
                                        }
                                      },
                                      label: Texts.translate(Texts.registerFirstNameLabel, context),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.person_rounded,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0,
                                    ),
                                    child: dynamicFormField(
                                      controller:
                                      studentHomeCubit.sSecondNameController,
                                      type: TextInputType.text,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                            'pleaseEnterYourFullName',
                                          )
                                              .toString();
                                        }
                                      },
                                      label: Texts.translate(Texts.registerLastNameLabel, context),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.person_rounded,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0,
                                    ),
                                    child: dynamicFormField(
                                      controller:
                                      studentHomeCubit.sEmailController,
                                      type: TextInputType.emailAddress,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                            'pleaseEnterYourEmailAddress',
                                          )
                                              .toString();
                                        }
                                      },
                                      label: Texts.translate(Texts.registerEmailLabel, context),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.email_outlined,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0,
                                    ),
                                    child: dynamicFormField(
                                      controller:
                                      studentHomeCubit.sPhoneController,
                                      type: TextInputType.phone,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                            'pleaseEnterYourPhone',
                                          )
                                              .toString();
                                        } else if (value.length < 11 ||
                                            value.length > 15) {
                                          return AppLocalizations.of(context)!
                                              .translate('phoneWrong')
                                              .toString();
                                        }
                                      },
                                      label: Texts.translate(Texts.registerPhoneLabel, context),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.phone_android,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     top: 24.0,
                                  //     bottom: 0.0,
                                  //   ),
                                  //   child: Row(
                                  //     children: [
                                  //       Text(
                                  //         'تغير كلمة السر',
                                  //         style: TextStyles
                                  //             .studentHomeProfilePersonalAccountTextStyle,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 0.0),
                                  //   child: dynamicFormField(
                                  //     controller:
                                  //         studentHomeCubit.sPasswordController,
                                  //     type: TextInputType.visiblePassword,
                                  //     suffixIcon: studentHomeCubit.suffix,
                                  //     isValidate: false,
                                  //     isLabel: true,
                                  //     borderRadius: 10,
                                  //     isPassword: studentHomeCubit.isPassword,
                                  //     suffixPressed: () {
                                  //       studentHomeCubit
                                  //           .changePasswordVisibility();
                                  //     },
                                  //     label: Texts.registerPasswordLabel,
                                  //     labelColor: AppColor.babyBlue,
                                  //     prefix: Icons.lock_outline,
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 5.0,
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 0.0),
                                  //   child: dynamicFormField(
                                  //     controller: studentHomeCubit
                                  //         .sConfirmPasswordController,
                                  //     type: TextInputType.visiblePassword,
                                  //     suffixIcon: studentHomeCubit.suffix,
                                  //     isValidate: false,
                                  //     isLabel: true,
                                  //     borderRadius: 10,
                                  //     onSubmit: (value) {
                                  //       // if (formKey.currentState!
                                  //       //     .validate()) {
                                  //       //   globalCubit
                                  //       //       .userRegister(
                                  //       //     email: sEmailController
                                  //       //         .text,
                                  //       //     password:
                                  //       //         sPasswordController
                                  //       //             .text,
                                  //       //     fname:
                                  //       //         sFirstNameController
                                  //       //             .text,
                                  //       //     sname:
                                  //       //         sSecondNameController
                                  //       //             .text,
                                  //       //     phone: sPhoneController
                                  //       //         .text,
                                  //       //     context: context,
                                  //       //   );
                                  //       // }
                                  //     },
                                  //     isPassword: studentHomeCubit.isPassword,
                                  //     suffixPressed: () {
                                  //       studentHomeCubit
                                  //           .changePasswordVisibility();
                                  //     },
                                  //     label: Texts.registerConfirmPasswordLabel,
                                  //     labelColor: AppColor.babyBlue,
                                  //     prefix: Icons.lock_outline,
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24.0,
                                      bottom: 0.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          Texts.translate(Texts.studentHomeProfileMoreText, context),
                                          style: TextStyles
                                              .studentHomeProfilePersonalAccountTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
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
                                      items: studentHomeCubit.genderList
                                          .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyles
                                                  .registerGenderListItemStyle,
                                            ),
                                          ))
                                          .toList(),
                                      value:
                                      studentHomeCubit.selectedGender ?? '',
                                      onChanged: (String? value) {
                                        studentHomeCubit.selectedGender = value!;
                                        studentHomeCubit.changeLocalState();
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                        ),
                                        height: 40,
                                        width: double.infinity,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0,
                                    ),
                                    child: Container(
                                      height: 4.0,
                                      width: double.infinity,
                                      color: AppColor.indigoDye,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          (studentHomeCubit.selectedGender ==
                                              Texts.translate(Texts.registerSelectGenderText, context))
                                              ? Texts
                                              .translate(Texts
                                              .registerPleaseSelectGenderText, context)
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
                                    child: DropdownButton2<String>(
                                      underline: Container(
                                        color: AppColor.indigoDye,
                                        height: 10.0,
                                      ),
                                      isExpanded: false,
                                      hint: Text(
                                        Texts.translate(Texts.registerSelectLevelText, context),
                                        style:
                                        TextStyles.registerSelectLevelStyle,
                                      ),
                                      items: studentHomeCubit.allLevelsTitle
                                          .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyles
                                                  .registerLevelsListItemStyle,
                                            ),
                                          ))
                                          .toList(),
                                      value: studentHomeCubit.selectedLevel,
                                      onChanged: (String? value) {
                                        studentHomeCubit.selectedLevel = value;
                                        studentHomeCubit.changeLocalState();
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                        ),
                                        height: 40,
                                        width: double.infinity,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: Container(
                                      height: 4.0,
                                      width: double.infinity,
                                      color: AppColor.indigoDye,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                        ),
                                        child: Text(
                                          (studentHomeCubit.selectedLevel ==
                                              Texts.translate(Texts.registerSelectLevelText, context))
                                              ? Texts
                                              .translate(Texts
                                              .registerPleaseSelectLevelText, context)
                                              : '',
                                          style: TextStyles
                                              .registerPleaseSelectLevelStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ConditionalBuilder(
                                    condition:
                                    state is! StudentUpdateLoadingState,
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColor.honeyYellow,
                                        )),
                                    builder: (context) => CustomElevation(
                                      color: AppColor.honeyYellow,
                                      radius: 21.0,
                                      opacity: 0.8,
                                      child: MaterialButton(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            17.0,
                                        minWidth:
                                        MediaQuery.of(context).size.width / 3,
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            21.0,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (studentHomeCubit
                                              .formKey.currentState!
                                              .validate() &&
                                              studentHomeCubit.selectedLevel !=
                                                  Texts.translate(Texts.registerSelectLevelText, context) &&
                                              studentHomeCubit.selectedGender !=
                                                  Texts
                                                      .translate(Texts
                                                      .registerSelectGenderText, context)) {
                                            studentHomeCubit.userUpdate(
                                              email: studentHomeCubit
                                                  .sEmailController.text,
                                              phone: studentHomeCubit
                                                  .sPhoneController.text,
                                              gender: studentHomeCubit
                                                  .selectedGender
                                                  .toString(),
                                              context: context,
                                              fname: studentHomeCubit
                                                  .sFirstNameController.text,
                                              lname: studentHomeCubit
                                                  .sSecondNameController.text,
                                            );
                                          }
                                        },
                                        color: AppColor.honeyYellow,
                                        child: Text(
                                          Texts.translate(Texts.continueText, context),
                                          textAlign: TextAlign.center,
                                          style: TextStyles.continueTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
