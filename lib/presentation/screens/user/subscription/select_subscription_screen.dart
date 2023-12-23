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
import '../../../widget/flat_button.dart';

class SubscriptionSelectionScreen extends StatelessWidget {
  const SubscriptionSelectionScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);
  final ScreenArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          return Scaffold(
            backgroundColor: AppColor.babyBlue,
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
                            'اختر طريقة الاشتراك',
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
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            '/course_subscribe_by_id',
                            arguments: ScreenArguments(
                              'id',
                              arguments!.message,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 250.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: AppColor.indigoDye,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child:  const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'اشترك باختيار الحزمة',
                                    style: TextStyle(
                                      fontFamily: 'cairo',
                                      color: AppColor.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            '/course_subscribe_by_code',
                            arguments: ScreenArguments(
                              'id',
                              arguments!.message,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 250.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: AppColor.indigoDye,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child:  const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'اشترك بادخال الكود',
                                    style: TextStyle(
                                      fontFamily: 'cairo',
                                      color: AppColor.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      ),
    );
  }
}
