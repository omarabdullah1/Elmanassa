import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../styles/colors.dart';
import '../../../widget/custom_course_card _widget.dart';
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
        // print(studentHomeCubit.myCoursesModel!.courses!.length);
        // print(CacheHelper.sharedPreferences.getString('token') != null);
        // print(studentHomeCubit.myCoursesModel!.courses!.isNotEmpty||studentHomeCubit.myCoursesModel!.courses!.length!=0);
        // print(studentHomeCubit.myCoursesModel!.courses!.isNotEmpty);
        // print(studentHomeCubit.myCoursesModel!.courses!.length!=0);
        // print(studentHomeCubit.myCoursesModel!.courses!.length <= 3);

        List<Widget> widgetsUnits = [];
        if(CacheHelper.sharedPreferences.getString('token') != null) {
          if (studentHomeCubit.myCoursesModel!.courses!.isNotEmpty) {
            for (int index = 0;
            index < studentHomeCubit.myCoursesModel!.courses!.length;
            index++) {
              widgetsUnits.add(CustomMyCourseWidget(
                domain: domain,
                course: studentHomeCubit.myCoursesModel!.courses![index]!,
                isEnrolled: true,
              ));
            }
            if (studentHomeCubit.myCoursesModel!.courses!.length <= 3) {
              widgetsUnits.add(
                SizedBox(
                  height: (MediaQuery
                      .of(context)
                      .size
                      .height -
                      (360 +
                          (studentHomeCubit.myCoursesModel!.courses!.length *
                              130))),
                ),
              );
            }
          } else {
            widgetsUnits.add(const Text('لا توجد كورسات حتي الان قم بالتسجيل'));
            if (CacheHelper.sharedPreferences.getString('token') != null) {
              if (studentHomeCubit.myCoursesModel!.courses!.length <= 3 ||
                  studentHomeCubit.myCoursesModel!.courses!.isEmpty) {
                widgetsUnits.add(
                  SizedBox(
                    height: (MediaQuery
                        .of(context)
                        .size
                        .height - 170),
                  ),
                );
              }
            } else {
              widgetsUnits.add(
                SizedBox(
                  height: (MediaQuery
                      .of(context)
                      .size
                      .height - 170),
                ),
              );
            }
          }
        }
        return CacheHelper.sharedPreferences.getString('token') == null
            ? Scaffold(
                backgroundColor: AppColor.babyBlue,
                body: Localizations.override(
                  context: context,
                  locale: const Locale('en'),
                  child: Builder(
                    builder: (context) => SafeArea(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // await Future.wait(
                          // [bloc.getCourses(), bloc.getBanners()]);
                          await studentHomeCubit.getMyCourses();
                        },
                        child: CacheHelper.sharedPreferences
                                    .getString('token') ==
                                null
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Center(
                                        child: Text('من فضلك سجل الدخول')),
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
                                            '/entry',
                                          );
                                        },
                                        color: AppColor.roseMadder,
                                        child: const Text(
                                          'تسجيل الدخول',
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
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // const Center(child: Text('My Courses')),
                                    Container(
                                      width: double.infinity,
                                      // height:
                                      // MediaQuery.of(context).viewInsets.bottom == 0
                                      //     ? bloc.coursesModel!.courses!.isEmpty
                                      //     ? MediaQuery.of(context).size.height *
                                      //     0.33 +
                                      //     65
                                      //     : bloc.coursesModel!.courses!.length *
                                      //     180 +
                                      //     MediaQuery.of(context).size.height*0.18
                                      //     : MediaQuery.of(context).size.height *
                                      //     0.3,
                                      decoration: const BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30.0,
                                                    vertical: 20.0),
                                                child: Text(
                                                  'كورساتي',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColor.indigoDye,
                                                    fontSize: 22.0,
                                                    fontFamily: 'cairo',
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                                                      child: Column(
                                                        children: widgetsUnits,
                                                      ),
                                                    )
                                                  : const Text(
                                                      'لا توجد كورسات الي الان قم بالتسجيل',
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
                ),
              )
            : studentHomeCubit.myCoursesModel != null &&
                    studentHomeCubit.bannersModel != null
                ? Scaffold(
                    backgroundColor: AppColor.babyBlue,
                    body: Localizations.override(
                      context: context,
                      locale: const Locale('en'),
                      child: Builder(
                        builder: (context) => SafeArea(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              // await Future.wait(
                              // [studentHomeCubit.getCourses(), studentHomeCubit.getBanners()]);
                              await studentHomeCubit.getMyCourses();
                            },
                            child: CacheHelper.sharedPreferences
                                        .getString('token') ==
                                    null
                                ? SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Center(
                                            child: Text('من فضلك سجل الدخول')),
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
                                                '/entry',
                                              );
                                            },
                                            color: AppColor.roseMadder,
                                            child: const Text(
                                              'تسجيل الدخول',
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
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // const Center(child: Text('My Courses')),
                                        Container(
                                          width: double.infinity,
                                          // height:
                                          // MediaQuery.of(context).viewInsets.bottom == 0
                                          //     ? studentHomeCubit.coursesModel!.courses!.isEmpty
                                          //     ? MediaQuery.of(context).size.height *
                                          //     0.33 +
                                          //     65
                                          //     : studentHomeCubit.coursesModel!.courses!.length *
                                          //     180 +
                                          //     MediaQuery.of(context).size.height*0.18
                                          //     : MediaQuery.of(context).size.height *
                                          //     0.3,
                                          decoration: const BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              topRight: Radius.circular(30.0),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30.0,
                                                            vertical: 20.0),
                                                    child: Text(
                                                      'كورساتي',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.indigoDye,
                                                        fontSize: 22.0,
                                                        fontFamily: 'cairo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state is! GetCoursesLoadingState
                                                  ? !studentHomeCubit
                                                          .myCoursesModel!
                                                          .courses!
                                                          .isNotEmpty
                                                      ? SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                          child: Column(
                                                            children:
                                                                widgetsUnits,
                                                          ),
                                                        )
                                                      : Column(
                                                          children:
                                                              widgetsUnits,
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
