import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../../generated/assets.dart';
import '../../../constants/screens.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';
import '../../widget/back_button.dart';
import '../../widget/custom_elevation.dart';
import '../../widget/dynamic_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit(),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) async {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          if (state is LoginSuccessState) {
            CacheHelper.saveDataSharedPreference(
              key: 'id',
              value: globalCubit.loginModel!.userData!.user!.id,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'token',
              value: globalCubit.loginModel!.userData!.token,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'email',
              value: globalCubit.emailController.text.toString(),
            );
            CacheHelper.saveDataSharedPreference(
              key: 'password',
              value: globalCubit.passwordController.text.toString(),
            );

            CacheHelper.saveDataSharedPreference(
              key: 'isParent',
              value: globalCubit.isParentLogin,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'first_name',
              value: globalCubit.loginModel!.userData!.user!.firstName!,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'last_name',
              value: globalCubit.loginModel!.userData!.user!.lastName!,
            );
            // CacheHelper.saveDataSharedPreference(
            //   key: 'code',
            //   value: globalCubit.loginModel!.userData!.user!.code!,
            // );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Screens.studentHomeScreen,
              (route) => false,
            );
          } else if (state is LoginParentSuccessState) {
            CacheHelper.saveDataSharedPreference(
              key: 'id',
              value: globalCubit.parentModel!.userData!.user!.id,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'token',
              value: globalCubit.parentModel!.userData!.token,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'email',
              value: globalCubit.emailController.text.toString(),
            );
            CacheHelper.saveDataSharedPreference(
              key: 'password',
              value: globalCubit.passwordController.text.toString(),
            );
            CacheHelper.saveDataSharedPreference(
              key: 'isParent',
              value: globalCubit.isParentLogin,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'first_name',
              value: globalCubit.parentModel!.userData!.user!.firstName!,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'last_name',
              value: globalCubit.parentModel!.userData!.user!.lastName!,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Screens.parentHomeScreen,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Builder(builder: (context) {
            final GlobalCubit globalCubit = context.read<GlobalCubit>();
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.177,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 5.0,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Texts.translate(Texts.loginHi, context),
                                    style: TextStyles.loginHiStyle,
                                  ),
                                  const BackButtonWidget(
                                    height: 30.0,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    Texts.translate(Texts.loginWelcomeForYou, context),
                                    textAlign: TextAlign.center,
                                    style: TextStyles.loginWelcomeForYouStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.86,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -10.0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).viewInsets.bottom == 0
                                //     ? MediaQuery.of(context).size.height * 0.55
                                //     : MediaQuery.of(context).size.height * 0.55,
                                decoration: const BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 45.0,
                                  ),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * 0.56,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Form(
                                        key: globalCubit.formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 60.0,
                                              ),
                                              child: dynamicFormField(
                                                controller:
                                                    globalCubit.emailController,
                                                type: TextInputType.emailAddress,
                                                isValidate: true,
                                                isLabel: true,
                                                borderRadius: 10,
                                                validate: (String value) {
                                                  if (value.isEmpty) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                          'pleaseEnterYourEmailAddress',
                                                        )
                                                        .toString();
                                                  }
                                                },
                                                onSubmit: (value) {},
                                                label: Texts.translate(Texts.loginEmailLabel, context),
                                                labelColor: AppColor.babyBlue,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 60.0),
                                              child: dynamicFormField(
                                                controller: globalCubit
                                                    .passwordController,
                                                type:
                                                    TextInputType.visiblePassword,
                                                suffixIcon: globalCubit.suffixOne,
                                                isValidate: true,
                                                isLabel: true,
                                                borderRadius: 10,
                                                onSubmit: (value) {
                                                  if (globalCubit
                                                      .formKey.currentState!
                                                      .validate()) {
                                                    globalCubit.userLogin(
                                                      email: globalCubit
                                                          .emailController.text,
                                                      password: globalCubit
                                                          .passwordController
                                                          .text,
                                                      context: context,
                                                    );
                                                  }
                                                },
                                                isPassword:
                                                    globalCubit.isPasswordOne,
                                                suffixPressed: () {
                                                  globalCubit
                                                      .changePasswordOneVisibility();
                                                },
                                                validate: (String value) {
                                                  if (value.isEmpty) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                          'pleaseEnterYourPassword',
                                                        )
                                                        .toString();
                                                  }
                                                },
                                                label: Texts.translate(Texts.loginPasswordLabel, context),
                                                labelColor: AppColor.babyBlue,
                                                suffixIconColor:
                                                    AppColor.indigoDye,
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(
                                            //     horizontal: 55.0,
                                            //   ),
                                            //   child: Align(
                                            //     alignment: Alignment.centerRight,
                                            //     child: TextButton(
                                            //       onPressed: () {
                                            //         // Navigator.pushNamed(
                                            //         //   context,
                                            //         //   loginScreen,
                                            //         // );
                                            //       },
                                            //       style: TextButton.styleFrom(
                                            //         foregroundColor: AppColor
                                            //             .roseMadder, // Text Color
                                            //       ),
                                            //       child: Text(
                                            //         Texts.translate(Texts.loginForgetPassword, context),
                                            //         style: TextStyles
                                            //             .loginForgetPasswordStyle,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            const SizedBox(
                                              height: 27.0,
                                            ),
                                            ConditionalBuilder(
                                              condition:
                                                  state is! LoginLoadingState,
                                              fallback: (context) => const Center(
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
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      17.0,
                                                  minWidth: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  elevation: 5.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              21.0)),
                                                  onPressed: () {
                                                    globalCubit.isParentLogin;
                                                    if (globalCubit
                                                        .formKey.currentState!
                                                        .validate()) {
                                                      globalCubit.isParentLogin
                                                          ? globalCubit
                                                              .parentLogin(
                                                              email: globalCubit
                                                                  .emailController
                                                                  .text,
                                                              password: globalCubit
                                                                  .passwordController
                                                                  .text,
                                                              context: context,
                                                            )
                                                          : globalCubit.userLogin(
                                                              email: globalCubit
                                                                  .emailController
                                                                  .text,
                                                              password: globalCubit
                                                                  .passwordController
                                                                  .text,
                                                              context: context,
                                                            );
                                                    }
                                                  },
                                                  color: AppColor.honeyYellow,
                                                  child: Text(
                                                    Texts.translate(Texts.continueText, context),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyles
                                                        .continueTextStyle,
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
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () => globalCubit
                                                        .changeIsParentLoginValue(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 45,
                                                        width: 83.0,
                                                        decoration: BoxDecoration(
                                                          color: globalCubit
                                                                  .isParentLogin
                                                              ? AppColor.white
                                                              : AppColor
                                                                  .roseMadder,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25.0),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            Texts.translate(Texts.parentText, context),
                                                            style: TextStyles
                                                                .parentStyle(
                                                              globalCubit
                                                                  .isParentLogin,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: () => globalCubit
                                                        .changeIsParentLoginValue(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 45,
                                                        width: 83.0,
                                                        decoration: BoxDecoration(
                                                          color: !globalCubit
                                                                  .isParentLogin
                                                              ? AppColor.white
                                                              : AppColor
                                                                  .roseMadder,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25.0),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            Texts.translate(Texts.studentText, context),
                                                            style: TextStyles
                                                                .studentStyle(
                                                              globalCubit
                                                                  .isParentLogin,
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
                                              height: 20.0,
                                            ),
                                            Text(
                                              Texts.translate(Texts.loginHaveAccountText, context),
                                              style: TextStyles
                                                  .loginHaveAccountStyle,
                                            ),
                                            const SizedBox(
                                              height: 1.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Screens.registerScreen,
                                                  );
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: AppColor
                                                      .roseMadder, // Text Color
                                                ),
                                                child: Text(
                                                  Texts.translate(Texts.register, context),
                                                  style: TextStyles.registerStyle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).viewInsets.bottom == 0
                                  ? MediaQuery.of(context).size.height * 0.03
                                  : MediaQuery.of(context).size.height * 0.03,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom == 0
                                        ? MediaQuery.of(context).size.height * 0.3
                                        : MediaQuery.of(context).size.height *
                                            0.3,
                                width: MediaQuery.of(context).size.width,
                                child: const CircleAvatar(
                                  backgroundColor: AppColor.babyBlue,
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).viewInsets.bottom == 0
                                  ? MediaQuery.of(context).size.height * 0.04
                                  : MediaQuery.of(context).size.height * 0.04,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom == 0
                                        ? MediaQuery.of(context).size.height * 0.3
                                        : MediaQuery.of(context).size.height *
                                            0.3,
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
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
