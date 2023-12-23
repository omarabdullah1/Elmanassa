import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:edumaster/data/local/cache_helper.dart';
import 'package:edumaster/presentation/widget/custom_course_card%20_widget.dart';
import 'package:edumaster/presentation/widget/custom_elevation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentHomeCubit, StudentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StudentHomeCubit studentHomeCubit = context.read<StudentHomeCubit>();
        return studentHomeCubit.coursesModel != null &&
                studentHomeCubit.bannersModel != null
            ? Localizations.override(
                context: context,
                locale: const Locale('en'),
                child: Builder(
                  builder: (context) => SafeArea(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.wait(
                            [studentHomeCubit.getCourses(), studentHomeCubit.getBanners(),studentHomeCubit.getMyCourses()]);
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        '،أهلا',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColor.indigoDye,
                                          fontSize: 18.0,
                                          fontFamily: 'cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CacheHelper.sharedPreferences.getString('token') != null
                                          ? Text(
                                              '${CacheHelper.sharedPreferences.getString('first_name')!} ${CacheHelper.sharedPreferences.getString('last_name')!}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: AppColor.roseMadder,
                                                fontSize: 20.0,
                                                fontFamily: 'cairo',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : const Text(
                                              'GUEST',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColor.roseMadder,
                                                fontSize: 20.0,
                                                fontFamily: 'cairo',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                      const Text(
                                        'طالب',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColor.roseMadder,
                                          fontSize: 14.0,
                                          fontFamily: 'cairo',
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
                                      .map((e) => CachedNetworkImage(
                                    imageUrl: e,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),)
                                      .toList(),
                                  options: CarouselOptions(
                                    height: 200,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: false,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: true,
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
                                  fontFamily: 'cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 120.0,
                              child: ListView.separated(
                                reverse: true,
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
                                    child: CustomElevation(
                                      color: AppColor.carosalBG,
                                      radius: 20.0,
                                      opacity: 0.4,
                                      child: Container(
                                        height: 120.0,
                                        width: 200.0,
                                        decoration: const BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                studentHomeCubit
                                                    .levelsModel!
                                                    .levels![index]!
                                                    .title
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: AppColor.indigoDye,
                                                  fontSize: 18.0,
                                                  fontFamily: 'cairo',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 20.0),
                                        child: Text(
                                          'كورسات المستوى',
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
                                      ? studentHomeCubit.coursesModel!.courses!.isNotEmpty
                                          ? SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Column(
                                                children: [
                                                  for (var i in studentHomeCubit
                                                      .coursesModel!.courses!)

                                                  CustomMyCourseWidget(
                                                    domain: domain,
                                                     course: i,
                                                    isEnrolled: i!.isEnrolled!,
                                                  ),

                                                  // Column(
                                                  //   children: [
                                                  //     CustomElevation(
                                                  //       radius: 20.0,
                                                  //       opacity: 0.6,
                                                  //       color: AppColor
                                                  //           .indigoDye,
                                                  //       child: Container(
                                                  //         decoration:
                                                  //             BoxDecoration(
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       20.0),
                                                  //           color: AppColor
                                                  //               .babyBlue,
                                                  //           border:
                                                  //               Border.all(
                                                  //             color: AppColor
                                                  //                 .indigoDye,
                                                  //             // You can change the color of the border here
                                                  //             width:
                                                  //                 2.5, // You can change the width of the border here
                                                  //           ),
                                                  //         ),
                                                  //         child: Column(
                                                  //           crossAxisAlignment:
                                                  //               CrossAxisAlignment
                                                  //                   .end,
                                                  //           children: [
                                                  //             Padding(
                                                  //               padding: const EdgeInsets.all(15.0),
                                                  //               child: Center(
                                                  //                 child: Padding(
                                                  //                   padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                                  //                   child: Container(
                                                  //                     width: double.infinity,
                                                  //                     height: 150.0,
                                                  //                     clipBehavior: Clip.hardEdge,
                                                  //                     decoration: BoxDecoration(
                                                  //                       color: AppColor.white,
                                                  //                       borderRadius: BorderRadius.circular(20.0),
                                                  //                       image: DecorationImage(
                                                  //                         image: NetworkImage(
                                                  //                           domain +
                                                  //                               i!.thumbnail!,
                                                  //                         ),
                                                  //                         fit: BoxFit.cover,
                                                  //                         colorFilter: ColorFilter.mode(
                                                  //                           AppColor.black.withOpacity(0.2),
                                                  //                           BlendMode.darken,
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     child: IconButton(
                                                  //                       onPressed: () {
                                                  //                         // Navigator.pushNamed(
                                                  //                         //   context,
                                                  //                         //   '/video',
                                                  //                         //   arguments: ScreenArguments(
                                                  //                         //     i!.title!,
                                                  //                         //     studentHomeCubit.coursesModel!.courses!.units!.first!
                                                  //                         //         .lessons!.isNotEmpty
                                                  //                         //         ? studentHomeCubit.courseDetailsModel!.course!.units!
                                                  //                         //         .first!.lessons!.first!.video!
                                                  //                         //         : 'https://www.youtube.com/watch?v=HQ_ytw58tC4',
                                                  //                         //   ),
                                                  //                         // );
                                                  //                       },
                                                  //                       icon: Container(
                                                  //                         decoration: BoxDecoration(
                                                  //                           shape: BoxShape.circle,
                                                  //                           color: AppColor.roseMadder,
                                                  //                           border: Border.all(
                                                  //                             color: AppColor
                                                  //                                 .white,
                                                  //                             // You can change the color of the border here
                                                  //                             width:
                                                  //                             3.0, // You can change the width of the border here
                                                  //                           ),
                                                  //                         ),
                                                  //                         child: const Icon(
                                                  //                           Icons.play_arrow,
                                                  //                           color: AppColor.white,
                                                  //                         ),
                                                  //                       ),
                                                  //                       iconSize: 40.0,
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Padding(
                                                  //               padding:
                                                  //                   const EdgeInsets
                                                  //                       .all(
                                                  //                       15.0),
                                                  //               child: Row(
                                                  //                 mainAxisAlignment:
                                                  //                     MainAxisAlignment
                                                  //                         .end,
                                                  //                 children: [
                                                  //                   for (var j
                                                  //                       in i
                                                  //                           .tags!)
                                                  //                     Padding(
                                                  //                       padding: const EdgeInsets
                                                  //                           .all(
                                                  //                           8.0),
                                                  //                       child:
                                                  //                           Container(
                                                  //                         width:
                                                  //                             80.0,
                                                  //                         height:
                                                  //                             30.0,
                                                  //                         decoration:
                                                  //                             BoxDecoration(
                                                  //                           color: AppColor.tagsColors[i.tags!.indexOf(j)].withOpacity(0.20),
                                                  //                           borderRadius: const BorderRadius.all(
                                                  //                             Radius.circular(8.0),
                                                  //                           ),
                                                  //                         ),
                                                  //                         child:
                                                  //                             FittedBox(
                                                  //                           fit: BoxFit.scaleDown,
                                                  //                           child: Padding(
                                                  //                             padding: const EdgeInsets.all(8.0),
                                                  //                             child: Center(
                                                  //                               child: Text(
                                                  //                                 j.toString(),
                                                  //                                 style: TextStyle(
                                                  //                                   color: AppColor.tagsColors[i.tags!.indexOf(j)],
                                                  //                                   fontSize: 18,
                                                  //                                   fontFamily: 'cairo',
                                                  //                                   fontWeight: FontWeight.bold,
                                                  //                                 ),
                                                  //                               ),
                                                  //                             ),
                                                  //                           ),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                 ],
                                                  //               ),
                                                  //             ),
                                                  //             Padding(
                                                  //               padding: const EdgeInsets
                                                  //                   .symmetric(
                                                  //                   horizontal:
                                                  //                       22.0),
                                                  //               child: Text(
                                                  //                 i.title!,
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .center,
                                                  //                 style:
                                                  //                     const TextStyle(
                                                  //                   color: AppColor
                                                  //                       .black,
                                                  //                   fontSize:
                                                  //                       20,
                                                  //                   fontFamily:
                                                  //                       'cairo',
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .bold,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             const SizedBox(
                                                  //               height: 10.0,
                                                  //             ),
                                                  //             Row(
                                                  //               mainAxisAlignment:
                                                  //                   MainAxisAlignment
                                                  //                       .center,
                                                  //               children: [
                                                  //                 CustomElevation(
                                                  //                   color: AppColor
                                                  //                       .roseMadder,
                                                  //                   radius:
                                                  //                       21.0,
                                                  //                   opacity:
                                                  //                       0.25,
                                                  //                   child:
                                                  //                       MaterialButton(
                                                  //                     height: MediaQuery.of(context).size.height *
                                                  //                         0.06,
                                                  //                     minWidth:
                                                  //                         MediaQuery.of(context).size.width *
                                                  //                             0.8,
                                                  //                     elevation:
                                                  //                         5.0,
                                                  //                     shape: RoundedRectangleBorder(
                                                  //                         borderRadius:
                                                  //                             BorderRadius.circular(21.0)),
                                                  //                     onPressed:
                                                  //                         () {
                                                  //                           Navigator.pushNamed(
                                                  //                             context,
                                                  //                             '/course_details',
                                                  //                             arguments: ScreenArguments(
                                                  //                               'id',
                                                  //                               i.id.toString(),
                                                  //                             ),
                                                  //                           );
                                                  //                     },
                                                  //                     color: AppColor
                                                  //                         .roseMadder,
                                                  //                     child:
                                                  //                         const Text(
                                                  //                       'أذهب للكورس',
                                                  //                       textAlign:
                                                  //                           TextAlign.center,
                                                  //                       style:
                                                  //                           TextStyle(
                                                  //                         color:
                                                  //                             Colors.white,
                                                  //                         fontSize:
                                                  //                             20,
                                                  //                         fontFamily:
                                                  //                             'cairo',
                                                  //                         fontWeight:
                                                  //                             FontWeight.w700,
                                                  //                       ),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //               ],
                                                  //             ),
                                                  //             const SizedBox(
                                                  //               height: 20.0,
                                                  //             )
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //     const SizedBox(
                                                  //       height: 30.0,
                                                  //     ),
                                                  //   ],
                                                  // )

                                                ],
                                              ),
                                            )
                                          : Column(
                                            children: [
                                              const Text(
                                                  'لا توجد كورسات لهذا المستوي',
                                                ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height-600 + 120*(studentHomeCubit.coursesModel!.courses!.length),
                                              ),
                                            ],
                                          )
                                      : Column(
                                        children: [
                                          const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height-600 + 120*(studentHomeCubit.coursesModel!.courses!.length),
                                          ),
                                        ],
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
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
