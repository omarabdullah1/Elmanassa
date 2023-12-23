import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../../main.dart';
import '../../styles/colors.dart';
import '../../widget/custom_elevation.dart';
import '../../widget/dynamicFormField.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit()..changeLang(()=>delegate.changeLocale(const Locale('ar'))),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) async {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          if (state is LoginSuccessState) {
            CacheHelper.saveDataSharedPreference(
              key: 'id',
              value: globalCubit.loginModel!.user!.id,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'token',
              value: globalCubit
                  .loginModel!
                  .user!
                  .tokenData!
                  .accessToken,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'email',
              value: emailController.text.toString(),
            );
            CacheHelper.saveDataSharedPreference(
              key: 'password',
              value: passwordController.text.toString(),
            );

            CacheHelper.saveDataSharedPreference(
              key: 'isParent',
              value: globalCubit.isParentLogin,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'first_name',
              value: globalCubit
                  .loginModel!
                  .user!
                  .firstName!,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'last_name',
              value: globalCubit
                  .loginModel!
                  .user!
                  .lastName!,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'code',
              value: globalCubit
                  .loginModel!
                  .user!
                  .code!,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/student_home',
                  (route) => false,
            );
          } else if (state is LoginParentSuccessState) {
            CacheHelper.saveDataSharedPreference(
              key: 'id',
              value: globalCubit.parentModel!.user!.id,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'token',
              value: globalCubit
                  .parentModel!
                  .user!
                  .tokenData!
                  .accessToken,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'email',
              value: emailController.text.toString(),
            );
            CacheHelper.saveDataSharedPreference(
              key: 'password',
              value: passwordController.text.toString(),
            );
            CacheHelper.saveDataSharedPreference(
              key: 'isParent',
              value: globalCubit.isParentLogin,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'first_name',
              value: globalCubit
                  .parentModel!
                  .user!
                  .firstName!,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'last_name',
              value: globalCubit
                  .parentModel!
                  .user!
                  .lastName!,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/parent_home',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Builder(builder: (context) {
            final GlobalCubit globalCubit = context.read<GlobalCubit>();
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.06,
                        right: MediaQuery.of(context).size.width * 0.1,
                        child: const Text(
                          '..أهلا',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.12,
                        right: MediaQuery.of(context).size.width * 0.1,
                        child: const Text(
                          'مرحبا بك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                          height: MediaQuery.of(context).viewInsets.bottom == 0
                              ? MediaQuery.of(context).size.height * 0.55
                              : MediaQuery.of(context).size.height * 0.3,
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
                        top: MediaQuery.of(context).viewInsets.bottom == 0
                            ? MediaQuery.of(context).size.height * 0.18
                            : MediaQuery.of(context).size.height * 0.16,
                        // left: MediaQuery.of(context).size.width -
                        //     (MediaQuery.of(context).size.width * 0.46) * 2.155,
                        child: Stack(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom ==
                                        0
                                    ? MediaQuery.of(context).size.height * 0.34
                                    : MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: const CircleAvatar(
                                  backgroundColor: AppColor.babyBlue,
                                )),
                            SizedBox(
                              height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom ==
                                      0
                                  ? MediaQuery.of(context).size.height * 0.35
                                  : MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              child: const Image(
                                image: AssetImage(
                                  'assets/images/person.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        height: MediaQuery.of(context).viewInsets.bottom == 0
                            ? MediaQuery.of(context).size.height * 0.48
                            : MediaQuery.of(context).size.height * 0.22,
                        child: SingleChildScrollView(
                          child: Builder(
                              builder: (context) => SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
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
                                              // SizedBox(
                                              //   height: MediaQuery.of(context)
                                              //           .size
                                              //           .height *
                                              //       0.05,
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 60.0),
                                                child: dynamicFormField(
                                                  controller: emailController,
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
                                                  label: 'الايميل/رقم الهاتف',
                                                  labelColor: AppColor.babyBlue,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 60.0),
                                                child: dynamicFormField(
                                                  controller:
                                                      passwordController,
                                                  type: TextInputType
                                                      .visiblePassword,
                                                  suffixIcon:
                                                      globalCubit
                                                          .suffix,
                                                  isValidate: true,
                                                  isLabel: true,
                                                  borderRadius: 10,
                                                  onSubmit: (value) {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      globalCubit
                                                          .userLogin(
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        context: context,
                                                      );
                                                    }
                                                  },
                                                  isPassword:
                                                      globalCubit
                                                          .isPassword,
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
                                                  label: 'كلمة المرور',
                                                  labelColor: AppColor.babyBlue,
                                                  suffixIconColor:
                                                      AppColor.indigoDye,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 55.0,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // Navigator.pushNamed(
                                                      //   context,
                                                      //   '/login',
                                                      // );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: AppColor
                                                          .roseMadder, // Text Color
                                                    ),
                                                    child: const Text(
                                                      'هل نسيت كلمة السر؟',
                                                      style: TextStyle(
                                                        // fontFamily: 'cairo',
                                                        color:
                                                            AppColor.indigoDye,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 27.0,
                                              ),
                                              ConditionalBuilder(
                                                condition:
                                                    state is! LoginLoadingState,
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
                                                                        21.0)),
                                                    onPressed: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        globalCubit
                                                                .isParentLogin
                                                            ? globalCubit
                                                                .parentLogin(
                                                                email:
                                                                    emailController
                                                                        .text,
                                                                password:
                                                                    passwordController
                                                                        .text,
                                                                context:
                                                                    context,
                                                              )
                                                            : globalCubit
                                                                .userLogin(
                                                                email:
                                                                    emailController
                                                                        .text,
                                                                password:
                                                                    passwordController
                                                                        .text,
                                                                context:
                                                                    context,
                                                              );
                                                      }
                                                    },
                                                    color: AppColor.honeyYellow,
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
                                                          .changeIsParentLoginValue(),
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
                                                                    .isParentLogin
                                                                ? AppColor.white
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
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'cairo',
                                                                color: globalCubit
                                                                        .isParentLogin
                                                                    ? AppColor
                                                                        .indigoDye
                                                                    : AppColor
                                                                        .white,
                                                                fontSize: 16.0,
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
                                                          .changeIsParentLoginValue(),
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
                                                                    .isParentLogin
                                                                ? AppColor.white
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
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'cairo',
                                                                color: !globalCubit
                                                                        .isParentLogin
                                                                    ? AppColor
                                                                        .indigoDye
                                                                    : AppColor
                                                                        .white,
                                                                fontSize: 16.0,
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
                                                height: 20.0,
                                              ),
                                              const Text(
                                                'اذا كان لديك حساب بالفعل',
                                                style: TextStyle(
                                                  fontFamily: 'cairo',
                                                  color: AppColor.indigoDye,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 1.0,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/register',
                                                  );
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: AppColor
                                                      .roseMadder, // Text Color
                                                ),
                                                child: const Text(
                                                  'حساب جديد',
                                                  style: TextStyle(
                                                    fontFamily: 'cairo',
                                                    color: AppColor.roseMadder,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
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
    path_0.moveTo(72.748, 15);
    path_0.lineTo(40, 15);
    path_0.cubicTo(17.9086, 15, 0, 32.9086, 0, 55);
    path_0.lineTo(0, 444);
    path_0.lineTo(360, 444);
    path_0.lineTo(360, 55);
    path_0.cubicTo(360, 32.9086, 342.091, 15, 320, 15);
    path_0.lineTo(295.252, 15);
    path_0.cubicTo(268.654, 46.7847, 228.688, 67, 184, 67);
    path_0.cubicTo(139.312, 67, 99.3465, 46.7847, 72.748, 15);
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
