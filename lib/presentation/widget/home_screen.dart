import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../business_logic/student_home_cubit/student_home_state.dart';
import '../../constants/end_points.dart';
import '../../data/local/args.dart';
import '../../data/local/cache_helper.dart';
import '../styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentHomeCubit, StudentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StudentHomeCubit studentHomeCubit = context.read<StudentHomeCubit>();
        return studentHomeCubit.coursesModel != null &&
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
                          await Future.wait(
                              [studentHomeCubit.getCourses(), studentHomeCubit.getBanners()]);
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          '،أهلا',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColor.indigoDye,
                                            fontSize: 18.0,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${CacheHelper.sharedPreferences.getString('first_name')} ${CacheHelper.sharedPreferences.getString('last_name')!}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: AppColor.roseMadder,
                                            fontSize: 20.0,
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'طالب',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColor.roseMadder,
                                            fontSize: 14.0,
                                            fontFamily: 'Tajawal',
                                            // fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      'assets/images/person.png',
                                      fit: BoxFit.contain,
                                      height: 80.0,
                                      width: 80.0,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Padding(
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
                                    items: studentHomeCubit.allBanners!
                                        .map(
                                          (e) => Image(
                                            image: NetworkImage(e),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                      height: 200,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 1),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'المستويات',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.indigoDye,
                                    fontSize: 22.0,
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 120.0,
                                child: ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          InkWell(
                                    onTap: () async {
                                      await studentHomeCubit
                                          .getCoursesByLevel(
                                        studentHomeCubit
                                            .levelsModel!
                                            .levels![index]!
                                            .order!,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 120.0,
                                        width: 100.0,
                                        decoration: const BoxDecoration(
                                          color: AppColor.carosalBG,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            studentHomeCubit
                                                .levelsModel!
                                                .levels![index]!
                                                .title
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(),
                                  itemCount: studentHomeCubit
                                      .levelsModel!
                                      .levels!
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom ==
                                        0
                                    ? MediaQuery.of(context).size.height * 0.6
                                    : MediaQuery.of(context).size.height * 0.3,
                                decoration: const BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 20.0),
                                      child: Text(
                                        'كورسات المستوى',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColor.indigoDye,
                                          fontSize: 22.0,
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    state is! GetCoursesLoadingState
                                        ? Expanded(
                                            child: studentHomeCubit.coursesModel!.courses!
                                                    .isNotEmpty
                                                ? ListView.separated(
                                                    itemBuilder:
                                                        (context, index) =>
                                                            InkWell(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                          context,
                                                          '/course_details',
                                                          arguments:
                                                              ScreenArguments(
                                                            'id',
                                                            studentHomeCubit
                                                                .coursesModel!
                                                                .courses![
                                                                    index]!
                                                                .id
                                                                .toString(),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 30.0,
                                                        ),
                                                        child: Container(
                                                          height: 160.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppColor
                                                                .carosalBG,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  35.0),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child:
                                                                Image.network(
                                                              '$domain/${studentHomeCubit
                                                                      .coursesModel!
                                                                      .courses!
                                                                      .first!
                                                                      .thumbnail!}',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    itemCount: studentHomeCubit
                                                        .coursesModel!
                                                        .courses!
                                                        .length,
                                                  )
                                                : const Center(
                                                    child: Text(
                                                      'No Courses for this level',
                                                    ),
                                                  ),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  ],
                                ),
                              ),
                              // Text(
                              //   CacheHelper.getDataFromSharedPreference(
                              //           key: 'id')
                              //       .toString(),
                              // ),
                              // Text(
                              //   CacheHelper.getDataFromSharedPreference(
                              //           key: 'email')
                              //       .toString(),
                              // ),
                              // Text(
                              //   CacheHelper.getDataFromSharedPreference(
                              //           key: 'password')
                              //       .toString(),
                              // ),

                              // Expanded(
                              //   child: ListView.separated(
                              //     itemBuilder:
                              //         (BuildContext context, int index) =>
                              //             InkWell(
                              //       onTap: () {
                              //         Navigator.pushNamed(
                              //           context,
                              //           '/course_details',
                              //           arguments: ScreenArguments(
                              //             'id',
                              //             HomeCubit.get(context)
                              //                 .coursesModel!
                              //                 .courses![index]!
                              //                 .id
                              //                 .toString(),
                              //           ),
                              //         );
                              //       },
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(20.0),
                              //         child: SizedBox(
                              //           height: 120.0,
                              //           child: Row(
                              //             children: [
                              //               Stack(
                              //                 alignment:
                              //                     AlignmentDirectional
                              //                         .bottomStart,
                              //                 children: [
                              //                   Image(
                              //                     image: NetworkImage(
                              //                       domain +
                              //                           HomeCubit.get(
                              //                                   context)
                              //                               .coursesModel!
                              //                               .courses!
                              //                               .first!
                              //                               .thumbnail!,
                              //                     ),
                              //                     width: 120.0,
                              //                     height: 120.0,
                              //                     fit: BoxFit.contain,
                              //                   ),
                              //                 ],
                              //               ),
                              //               const SizedBox(
                              //                 width: 20.0,
                              //               ),
                              //               Expanded(
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment
                              //                           .start,
                              //                   children: [
                              //                     Text(
                              //                       HomeCubit.get(context)
                              //                           .coursesModel!
                              //                           .courses!
                              //                           .first!
                              //                           .title!,
                              //                       maxLines: 2,
                              //                       overflow: TextOverflow
                              //                           .ellipsis,
                              //                       style:
                              //                           const TextStyle(
                              //                         fontSize: 14.0,
                              //                         height: 1.3,
                              //                       ),
                              //                     ),
                              //                     const Spacer(),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     separatorBuilder:
                              //         (BuildContext context, int index) =>
                              //             const SizedBox(),
                              //     itemCount: HomeCubit.get(context)
                              //         .coursesModel!
                              //         .courses!
                              //         .length,
                              //   ),
                              // )
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
