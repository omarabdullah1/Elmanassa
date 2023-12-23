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

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({
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
          if (studentHomeCubit.courseSubscriptionsModel != null) {
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
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: const Center(
                            child: Text(
                              'اشترك الان',
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
                child: studentHomeCubit.courseSubscriptionsModel!.status ==
                            200 &&
                        studentHomeCubit
                            .courseSubscriptionsModel!.subscriptions!.isNotEmpty
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'الحزم',
                                  style: TextStyle(
                                    fontFamily: 'cairo',
                                    color: AppColor.indigoDye,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  for (int i = studentHomeCubit.courseSubscriptionsModel!.subscriptions!.length - 1;
                                  i >= 0;
                                  i--)
                                    InkWell(
                                      onTap: () {
                                        studentHomeCubit
                                            .changeSelectedPackageIndexState(
                                                i);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20.0),
                                              color: AppColor.indigoDye,
                                              border: Border.all(
                                                  color: studentHomeCubit
                                                              .selectedPackage ==
                                                          i
                                                      ? AppColor.white
                                                      : AppColor.indigoDye,
                                                  width: 3.0)),
                                          height: 90.0,
                                          width: 90.0,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                child: Text(
                                                  'دروس ${studentHomeCubit.courseSubscriptionsModel!.subscriptions![i]!.sessionsNumber!}',
                                                  style: const TextStyle(
                                                    fontFamily: 'cairo',
                                                    color: AppColor.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                child: Text(
                                                  'اسابيع ${studentHomeCubit.courseSubscriptionsModel!.subscriptions![i]!.validatedWeeks!}',
                                                  style: const TextStyle(
                                                    fontFamily: 'cairo',
                                                    color: AppColor.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${studentHomeCubit.courseSubscriptionsModel!.subscriptions![studentHomeCubit.selectedPackage]!.price!} LE',
                                  style: const TextStyle(
                                    fontFamily: 'cairo',
                                    color: AppColor.indigoDye,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'السعر',
                                  style: TextStyle(
                                    fontFamily: 'cairo',
                                    color: AppColor.indigoDye,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          studentHomeCubit.listImage.isNotEmpty
                              ? const SizedBox()
                              : const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'حمل صورة فودافون كاش للاشتراك في الكورس*',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.roseMadder,
                                        fontSize: 18,
                                        fontFamily: 'cairo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                          studentHomeCubit.listImage.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 160.0,
                                    decoration: const BoxDecoration(
                                      color: AppColor.carosalBG,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CarouselSlider(
                                      items: studentHomeCubit.listImage
                                          .map(
                                            (e) => Stack(
                                              children: [
                                                Image.file(
                                                  File(e),
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                                Positioned(
                                                  top: 0.0,
                                                  right: 0.0,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColor.white,
                                                      ),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          studentHomeCubit
                                                              .removeImageFromList(
                                                            studentHomeCubit
                                                                .listImage
                                                                .indexOf(e),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          weight: 500,
                                                          size: 35.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                      options: CarouselOptions(
                                        height: 200,
                                        viewportFraction: 1.0,
                                        enlargeCenterPage: false,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: true,
                                        autoPlay: false,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            const Duration(seconds: 1),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomElevation(
                                  color: AppColor.roseMadder,
                                  radius: 21.0,
                                  opacity: 0.25,
                                  child: MaterialButton(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(21.0)),
                                    onPressed: () {
                                      studentHomeCubit.getImage(false);
                                    },
                                    color: AppColor.roseMadder,
                                    child: const Text(
                                      'تحميل الصورة',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'cairo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          studentHomeCubit.listImage.isEmpty
                              ? const SizedBox()
                              : ConditionalBuilder(
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
                                              0.8,
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(21.0)),
                                      onPressed: () {
                                        studentHomeCubit.userSubscribeById(
                                          subscriptionId: studentHomeCubit
                                              .courseSubscriptionsModel!
                                              .subscriptions![studentHomeCubit
                                                  .selectedPackage]!
                                              .id
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
                        ],
                      )
                    : const Center(
                        child: Text(
                          'لا توجد حزم للاشتراك الان*',
                          style: TextStyle(
                            color: AppColor.roseMadder,
                            fontSize: 18,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ),
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
