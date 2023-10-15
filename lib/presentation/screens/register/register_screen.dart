import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../styles/colors.dart';
import '../../widget/custom_elevation.dart';
import '../../widget/dynamicFormField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var bloc = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) async {
        if (state is RegisterSuccessState) {
          if (bloc.registerModel!.status == 200) {
            CacheHelper.saveDataSharedPreference(
              key: 'email',
              value: emailController.text,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'password',
              value: passwordController.text,
            );
            bloc.loginModel = null;
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/profile',
              (route) => false,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.babyBlue,
          body: Stack(
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
                top: MediaQuery.of(context).size.height * 0.195,
                left: 0.0,
                child: CustomPaint(
                  size: Size(
                    MediaQuery.of(context).size.width * 0.468,
                    MediaQuery.of(context).size.height * 0.145,
                  ),
                  painter: RPSCustomPainter(),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                child: SizedBox(
                  child: const Image(
                    image: AssetImage(
                      'assets/images/person.png',
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                bottom: 0.0,
                height: MediaQuery.of(context).viewInsets.bottom == 0
                    ? MediaQuery.of(context).size.height * 0.75
                    : MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  child: Localizations.override(
                    context: context,
                    locale: const Locale('ar'),
                    child: Builder(builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: dynamicFormField(
                                      controller: nameController,
                                      type: TextInputType.text,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                                  'pleaseEnterYourFullName')
                                              .toString();
                                        }
                                      },
                                      label: AppLocalizations.of(context)!
                                          .translate('fullName')
                                          .toString(),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.person_rounded,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: dynamicFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                                  'pleaseEnterYourEmailAddress')
                                              .toString();
                                        }
                                      },
                                      label: AppLocalizations.of(context)!
                                          .translate('email')
                                          .toString(),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.email_outlined,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: dynamicFormField(
                                      controller: phoneController,
                                      type: TextInputType.emailAddress,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate('pleaseEnterYourPhone')
                                              .toString();
                                        } else if (value.length < 11 ||
                                            value.length > 15) {
                                          return AppLocalizations.of(context)!
                                              .translate('phoneWrong')
                                              .toString();
                                        }
                                      },
                                      label: AppLocalizations.of(context)!
                                          .translate('phone')
                                          .toString(),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.phone_android,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: dynamicFormField(
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      suffixIcon: GlobalCubit.get(context).suffix,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      isPassword:
                                          GlobalCubit.get(context).isPassword,
                                      suffixPressed: () {
                                        GlobalCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                                'pleaseEnterYourPassword',
                                              )
                                              .toString();
                                        }
                                      },
                                      label: AppLocalizations.of(context)!
                                          .translate('password')
                                          .toString(),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.lock_outline,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: dynamicFormField(
                                      controller: confirmPasswordController,
                                      type: TextInputType.visiblePassword,
                                      suffixIcon: GlobalCubit.get(context).suffix,
                                      isValidate: true,
                                      isLabel: true,
                                      borderRadius: 10,
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          GlobalCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            context: context,
                                          );
                                        }
                                      },
                                      isPassword:
                                          GlobalCubit.get(context).isPassword,
                                      suffixPressed: () {
                                        GlobalCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                                  'pleaseEnterYourPassword')
                                              .toString();
                                        } else if (passwordController.text !=
                                            value) {
                                          return AppLocalizations.of(context)!
                                              .translate('passwordNotMatch')
                                              .toString();
                                        }
                                      },
                                      label: AppLocalizations.of(context)!
                                          .translate('confirmPassword')
                                          .toString(),
                                      labelColor: AppColor.babyBlue,
                                      prefix: Icons.lock_outline,
                                    ),
                                  ),
                                  // const Expanded(
                                  //   child: SizedBox(),
                                  // ),
                                  const SizedBox(
                                    height: 40.0,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! RegisterLoadingState,
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
                                            MediaQuery.of(context).size.width /
                                                3,
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(21.0)),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            GlobalCubit.get(context)
                                                .userRegister(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              phone: phoneController.text,
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
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/login',
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          AppColor.roseMadder, // Text Color
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(15.0),
                                  //   child: ConditionalBuilder(
                                  //     condition: state is! RegisterLoadingState,
                                  //     fallback: (context) => const Center(
                                  //         child: CircularProgressIndicator()),
                                  //     builder: (context) => MaterialButton(
                                  //       height: 55,
                                  //       minWidth:
                                  //           MediaQuery.of(context).size.width /
                                  //               3,
                                  //       elevation: 5.0,
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius:
                                  //               BorderRadius.circular(10)),
                                  //       onPressed: () {
                                  //         if (formKey.currentState!
                                  //             .validate()) {
                                  //           GlobalCubit.get(context)
                                  //               .userRegister(
                                  //             email: emailController.text,
                                  //             password: passwordController.text,
                                  //             name: nameController.text,
                                  //             phone: phoneController.text,
                                  //             context: context,
                                  //           );
                                  //         }
                                  //         // Navigator.push(context,MaterialPageRoute(builder: (context)=> RegisterScreen()));
                                  //       },
                                  //       child: Text(
                                  //         AppLocalizations.of(context)!
                                  //             .translate('register')
                                  //             .toString(),
                                  //         style: const TextStyle(
                                  //           fontSize: 20,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: AppColor.white,
                                  //         ),
                                  //       ),
                                  //       color: AppColor.button,
                                  //     ),
                                  //   ),
                                  // ),
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

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
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
