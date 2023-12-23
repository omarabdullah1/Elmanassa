import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edumaster/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../data/local/args.dart';
import '../../../styles/colors.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/dynamicFormField.dart';
import '../../../widget/flat_button.dart';

class SubscriptionByCodeScreen extends StatelessWidget {
  const SubscriptionByCodeScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);
  final ScreenArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()
        ..getCoursePackages(
          courseId: arguments!.message,
        ),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {
          if (state is SubscribeSuccessState) {
            state.subscribeModel.message.toString() ==
                    'Faild to subscribe course, may be the subscription package exceeded the limit'
                ? AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.scale,
                    title: 'Request Failed',
                    desc: state.subscribeModel.message.toString(),
                    // btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/student_home',
                        (route) => false,
                      );
                    },
                  ).show()
                : AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.scale,
                    title: 'Request Success',
                    desc: state.subscribeModel.message.toString(),
                    // btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/student_home',
                        (route) => false,
                      );
                    },
                  ).show();
          }
        },
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () => studentHomeCubit.changeExpandableState(),
              // ),
              appBar: CustomAppBar(
                appBarWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            tOrI: false,
                            icon: Icons.arrow_back_ios,
                            radius: 50.0,
                            height: 5.0,
                            minWidth: 5.0,
                            iconSize: 15.0,
                            iconColor: AppColor.roseMadder,
                            color: AppColor.white,
                            elevation: 0.0,
                            iconWidgetState: false,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 35.0,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: const Center(
                            child: Text(
                              'اشترك باختيار الكود',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                color: AppColor.indigoDye,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 45.0,
                          width: 45.0,
                          child: Image.asset(
                            'assets/images/person.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60.0,
                              ),
                              child: dynamicFormField(
                                controller: studentHomeCubit.codeController,
                                type: TextInputType.name,
                                isValidate: true,
                                isLabel: true,
                                borderRadius: 10,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'من فضلك قم بادخال كود الاشتراك';
                                  }
                                },
                                label: 'كود الاشتراك',
                                labelColor: AppColor.white,
                                suffixIconColor: AppColor.indigoDye,
                              ),
                            ),
                           Padding(
                             padding: const EdgeInsets.all(30.0),
                             child: ConditionalBuilder(
                                      condition: state is! SubscribeLoadingState,
                                      fallback: (context) => const Center(
                                          child: CircularProgressIndicator(
                                        color: AppColor.roseMadder,
                                      )),
                                      builder: (context) => CustomElevation(
                                        color: AppColor.roseMadder,
                                        radius: 21.0,
                                        opacity: 0.8,
                                        child: MaterialButton(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.08,
                                          minWidth:
                                              MediaQuery.of(context).size.width *
                                                  0.4,
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(21.0)),
                                          onPressed: () {
                                            studentHomeCubit.userSubscribeByCode(
                                              subscriptionCode: studentHomeCubit
                                                  .codeController.text
                                                  .toString(),
                                            );
                                          },
                                          color: AppColor.roseMadder,
                                          child: const Text(
                                            'أضغط للاشتراك الان',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: 'cairo',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                           ),
                          ],
                        )
                ),
              ),
            );
        },
      ),
    );
  }
}
