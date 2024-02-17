import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/custom_course_card.dart';
import '../../../widget/custom_elevation.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentHomeCubit, StudentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StudentHomeCubit studentHomeCubit =
            context.read<StudentHomeCubit>();
        return CacheHelper.sharedPreferences.getString('token') == null
            ? Scaffold(
                backgroundColor: AppColor.babyBlue,
                body: Builder(
                  builder: (context) => SafeArea(
                    child: RefreshIndicator(
                      color: AppColor.indigoDye,
                      onRefresh: () async {
                        // await Future.wait(
                        // [bloc.getCourses(), bloc.getBanners()]);
                        await studentHomeCubit.getMyCourses();
                      },
                      child: CacheHelper.sharedPreferences.getString('token') ==
                              null
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      Texts.translate(Texts.studentHomePleaseLoginText, context),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  CustomElevation(
                                    color: AppColor.roseMadder,
                                    radius: 21.0,
                                    opacity: 0.25,
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
                                        CacheHelper.sharedPreferences.clear();
                                        Navigator.pushNamed(
                                          context,
                                          Screens.entryScreen,
                                        );
                                      },
                                      color: AppColor.roseMadder,
                                      child: Text(
                                        Texts.translate(Texts.loginButton, context),
                                        textAlign: TextAlign.center,
                                        style: TextStyles.loginButtonStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 30.0,
                                                vertical: 20.0,
                                              ),
                                              child: Text(
                                                Texts.translate(Texts.studentHomeMyCoursesText, context),
                                                textAlign: TextAlign.center,
                                                style: TextStyles
                                                    .studentHomeMyCoursesTextStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                        state is! GetCoursesLoadingState
                                            ? studentHomeCubit.myCoursesModel!
                                                    .courses!.isNotEmpty
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    child: LayoutBuilder(
                                                        builder: (context,
                                                            constraints) {
                                                      double width =
                                                          constraints.maxWidth;
                                                      double height =
                                                          constraints.maxHeight;
                                                      return Container(
                                                        width: width,
                                                        height: height,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: AppColor.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                              30.0,
                                                            ),
                                                            topRight:
                                                                Radius.circular(
                                                              30.0,
                                                            ),
                                                          ),
                                                        ),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          30.0,
                                                                      vertical:
                                                                          20.0,
                                                                    ),
                                                                    child: Text(
                                                                      Texts
                                                                          .translate(Texts
                                                                          .studentHomeMyCoursesText, context),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyles
                                                                          .studentHomeMyCoursesTextStyle,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              state
                                                                      is! GetCoursesLoadingState
                                                                  ? !studentHomeCubit
                                                                          .myCoursesModel!
                                                                          .courses!
                                                                          .isNotEmpty
                                                                      ? SizedBox(
                                                                          height: MediaQuery.of(
                                                                                context,
                                                                              ).size.height *
                                                                              0.82,
                                                                        )
                                                                      : SizedBox(
                                                                          width: MediaQuery.of(
                                                                                context,
                                                                              ).size.width *
                                                                              0.9,
                                                                          child: (CacheHelper.sharedPreferences.getString('token') != null)
                                                                              ? (studentHomeCubit.myCoursesModel!.courses!.isNotEmpty)
                                                                                  ? Column(
                                                                                      children: studentHomeCubit.myCoursesModel!.courses!
                                                                                          .map((e) => CustomMyCourseWidget(
                                                                                                domain: domain,
                                                                                                course: studentHomeCubit.myCoursesModel!.courses![studentHomeCubit.myCoursesModel!.courses!.indexOf(e)]!,
                                                                                                isEnrolled: true,
                                                                                              ))
                                                                                          .toList(),
                                                                                    )
                                                                                  : const SizedBox()
                                                                              : const SizedBox(),
                                                                        )
                                                                  : const Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                : Text(
                                                    Texts
                                                        .translate(Texts
                                                        .studentHomeNoCoursesNowPleaseSubscribeText, context),
                                                  )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              )
            : studentHomeCubit.myCoursesModel != null &&
                    studentHomeCubit.bannersModel != null
                ? Scaffold(
                    backgroundColor: AppColor.babyBlue,
                    body: Builder(
                      builder: (context) => SafeArea(
                        child: RefreshIndicator(
                          color: AppColor.indigoDye,
                          onRefresh: () async {
                            // await Future.wait(
                            // [studentHomeCubit.getCourses(), studentHomeCubit.getBanners()]);
                            await studentHomeCubit.getMyCourses();
                          },
                          child:
                              CacheHelper.sharedPreferences
                                          .getString('token') ==
                                      null
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              Texts.translate(Texts.studentHomePleaseLoginText, context),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                          CustomElevation(
                                            color: AppColor.roseMadder,
                                            radius: 21.0,
                                            opacity: 0.25,
                                            child: MaterialButton(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.08,
                                              minWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          21.0)),
                                              onPressed: () {
                                                CacheHelper.sharedPreferences
                                                    .clear();
                                                Navigator.pushNamed(
                                                  context,
                                                  Screens.entryScreen,
                                                );
                                              },
                                              color: AppColor.roseMadder,
                                              child: Text(
                                                Texts.translate(Texts.loginButton, context),
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyles.loginButtonStyle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : LayoutBuilder(
                                      builder: (context, constraints) {
                                      double width = constraints.maxWidth;
                                      double height = constraints.maxHeight;
                                      return Container(
                                        width: width,
                                        height: height,
                                        decoration: const BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              // Row(
                                              //   children: [
                                              //     Padding(
                                              //       padding:
                                              //           const EdgeInsets.symmetric(
                                              //         horizontal: 30.0,
                                              //         vertical: 20.0,
                                              //       ),
                                              //       child: Text(
                                              //         Texts
                                              //             .studentHomeMyCoursesText,
                                              //         textAlign: TextAlign.center,
                                              //         style: TextStyles
                                              //             .studentHomeMyCoursesTextStyle,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              state is! GetCoursesLoadingState
                                                  ? !studentHomeCubit
                                                          .myCoursesModel!
                                                          .courses!
                                                          .isNotEmpty
                                                      ? SizedBox(
                                                          height: MediaQuery.of(
                                                                context,
                                                              ).size.height *
                                                              0.82,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                Texts
                                                                    .translate(Texts
                                                                    .studentHomeMyCoursesNoCoursesEnrolledNowText, context),
                                                                style: TextStyles
                                                                    .studentHomeMyCoursesNoCoursesStyle,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          width: MediaQuery.of(
                                                                context,
                                                              ).size.width *
                                                              0.9,
                                                          child: (CacheHelper
                                                                      .sharedPreferences
                                                                      .getString(
                                                                          'token') !=
                                                                  null)
                                                              ? (studentHomeCubit
                                                                      .myCoursesModel!
                                                                      .courses!
                                                                      .isNotEmpty)
                                                                  ? Column(
                                                                      children: studentHomeCubit
                                                                          .myCoursesModel!
                                                                          .courses!
                                                                          .map(
                                                                            (e) =>
                                                                                CustomMyCourseWidget(
                                                                              domain: domain,
                                                                              course: studentHomeCubit.myCoursesModel!.courses![studentHomeCubit.myCoursesModel!.courses!.indexOf(e)]!,
                                                                              isEnrolled: true,
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                    )
                                                                  : const SizedBox()
                                                              : const SizedBox(),
                                                        )
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                        ),
                      ),
                    ),
                  )
                : const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
      },
    );
  }
}
