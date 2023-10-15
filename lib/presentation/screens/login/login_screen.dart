import 'dart:developer';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../styles/colors.dart';
import '../../widget/custom_elevation.dart';
import '../../widget/dynamicFormField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var bloc = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          log(bloc.loginModel!.user!.firstName.toString());
          CacheHelper.saveDataSharedPreference(
            key: 'id',
            value: bloc.loginModel!.user!.id!,
          );
          CacheHelper.saveDataSharedPreference(
            key: 'email',
            value: emailController.text,
          );
          CacheHelper.saveDataSharedPreference(
            key: 'password',
            value: passwordController.text,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/profile',
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Localizations.override(
          context: context,
          locale: const Locale('ar'),
          child: Builder(builder: (context) {
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              body: SizedBox(
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
                          fontFamily: 'Tajawal',
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
                          fontFamily: 'Tajawal',
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
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 25.0,
                              color: AppColor.roseMadder,
                            ),
                            backgroundColor: AppColor.white,
                            mini: true,
                            elevation: 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).viewInsets.bottom == 0
                          ? MediaQuery.of(context).size.height * 0.23
                          : MediaQuery.of(context).size.height * 0.16,
                      // left: MediaQuery.of(context).size.width -
                      //     (MediaQuery.of(context).size.width * 0.46) * 2.155,
                      child: SizedBox(
                        child: const Image(
                          image: AssetImage(
                            'assets/images/person.png',
                          ),
                        ),
                        height: MediaQuery.of(context).viewInsets.bottom == 0
                            ? MediaQuery.of(context).size.height * 0.33
                            : MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).viewInsets.bottom == 0
                          ? MediaQuery.of(context).size.height * 0.370
                          : MediaQuery.of(context).size.height * 0.18,
                      left: 0.0,
                      child: CustomPaint(
                        size: Size(
                          MediaQuery.of(context).size.width * 0.464,
                          MediaQuery.of(context).size.height * 0.145,
                        ),
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      height: MediaQuery.of(context).viewInsets.bottom == 0
                          ? MediaQuery.of(context).size.height * 0.50
                          : MediaQuery.of(context).size.height * 0.22,
                      child: SingleChildScrollView(
                        child: Localizations.override(
                          context: context,
                          locale: const Locale('ar'),
                          child: Builder(builder: (context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.50,
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
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 60.0),
                                          child: dynamicFormField(
                                            controller: emailController,
                                            type: TextInputType.emailAddress,
                                            isValidate: true,
                                            isLabel: true,
                                            borderRadius: 10,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'pleaseEnterYourEmailAddress')
                                                    .toString();
                                              }
                                            },
                                            label: 'الاسم/رقم الهاتف',
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
                                            controller: passwordController,
                                            type: TextInputType.visiblePassword,
                                            suffixIcon:
                                                GlobalCubit.get(context).suffix,
                                            isValidate: true,
                                            isLabel: true,
                                            borderRadius: 10,
                                            onSubmit: (value) {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                GlobalCubit.get(context)
                                                    .userLogin(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  context: context,
                                                );
                                              }
                                            },
                                            isPassword: GlobalCubit.get(context)
                                                .isPassword,
                                            suffixPressed: () {
                                              GlobalCubit.get(context)
                                                  .changePasswordVisibility();
                                            },
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'pleaseEnterYourPassword')
                                                    .toString();
                                              }
                                            },
                                            label: 'كلمة المرور',
                                            labelColor: AppColor.babyBlue,
                                            suffixIconColor: AppColor.indigoDye,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 55.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              child: const Text(
                                                'هل نسيت كلمة السر؟',
                                                style: TextStyle(
                                                  // fontFamily: 'tajawal',
                                                  color: AppColor.indigoDye,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
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
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 27.0,
                                        ),
                                        ConditionalBuilder(
                                          condition:
                                              state is! LoginLoadingState,
                                          fallback: (context) => const Center(
                                              child: CircularProgressIndicator(
                                            color: AppColor.honeyYellow,
                                          )),
                                          builder: (context) => CustomElevation(
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
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  GlobalCubit.get(context)
                                                      .userLogin(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    context: context,
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                'أستمرار',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontFamily: 'Tajawal',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              color: AppColor.honeyYellow,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        const Text(
                                          'اذا كان لديك حساب بالفعل',
                                          style: TextStyle(
                                            fontFamily: 'tajawal',
                                            color: AppColor.indigoDye,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 1.0,
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'تسجيل الدخول',
                                            style: TextStyle(
                                              fontFamily: 'tajawal',
                                              color: AppColor.roseMadder,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/login',
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColor
                                                .roseMadder, // Text Color
                                          ),
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
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
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
