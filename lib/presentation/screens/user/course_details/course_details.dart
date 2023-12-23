import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edumaster/data/local/cache_helper.dart';
import 'package:edumaster/presentation/widget/custom_app_bar.dart';
import 'package:edumaster/presentation/widget/unit_card_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/args.dart';
import '../../../styles/colors.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/flat_button.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);
  final ScreenArguments? arguments;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudentHomeCubit()..getCourseDetails(id: widget.arguments!.message),
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
          if (studentHomeCubit.courseDetailsModel != null) {
            List<Widget> widgetsUnits = [];

            for (int index = 0;
                index <
                    studentHomeCubit.courseDetailsModel!.course!.units!.length;
                index++) {
              widgetsUnits.add(
                  // UnitCard(
                  //   title: 'Course Title',
                  //   unitLessonsLength:
                  //       studentHomeCubit.courseDetailsModel!.course!.units!.length,
                  //   units: studentHomeCubit.courseDetailsModel!.course!.units!,
                  //   index: index,
                  // ),
                  UnitCard(
                courseDetailsModelCourseUnits:
                    studentHomeCubit.courseDetailsModel!.course!.units![index]!,
              ));

              // Add a SizedBox as a separator, except for the last item
              if (index <
                  studentHomeCubit.courseDetailsModel!.course!.units!.length -
                      1) {
                widgetsUnits.add(const SizedBox(height: 10.0));
              }
            }
            // Add a SizedBox as a separator, except for the last item
            if (studentHomeCubit.courseDetailsModel!.course!.units!.length <=
                3) {
              widgetsUnits.add(
                SizedBox(
                  height: (MediaQuery.of(context).size.height -
                      (360 +
                          (studentHomeCubit
                                  .courseDetailsModel!.course!.units!.length *
                              130))),
                ),
              );
            }
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
                              'تفاصيل الدرس',
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          width: double.infinity,
                          height: 200.0,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: '$domain/${studentHomeCubit.courseDetailsModel!.course!.thumbnail!}',
                                fit: BoxFit.cover,
                                // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                //     CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/video',
                                    arguments: ScreenArguments(
                                      studentHomeCubit.courseDetailsModel!.course!.title!,
                                      studentHomeCubit.courseDetailsModel!.course!.units!.first!.lessons!.isNotEmpty
                                          ? studentHomeCubit.courseDetailsModel!.course!.units!.first!.lessons!.first!.video ??
                                          'https://www.youtube.com/watch?v=runIG2kMGbo'
                                          : 'https://www.youtube.com/watch?v=runIG2kMGbo',
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.play_circle,
                                  color: AppColor.roseMadder,
                                ),
                                iconSize: 80.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    studentHomeCubit.isVideos =
                                        !studentHomeCubit.isVideos;
                                    studentHomeCubit.changeIsVideosValue();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 45,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        color: studentHomeCubit.isVideos
                                            ? AppColor.white
                                            : AppColor.honeyYellow,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'التفاصيل',
                                          style: TextStyle(
                                            fontFamily: 'cairo',
                                            color: studentHomeCubit.isVideos
                                                ? AppColor.honeyYellow
                                                : AppColor.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    studentHomeCubit.isVideos =
                                        !studentHomeCubit.isVideos;
                                    studentHomeCubit.changeIsVideosValue();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 45,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        color: !studentHomeCubit.isVideos
                                            ? AppColor.white
                                            : AppColor.honeyYellow,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'الفيديوهات',
                                          style: TextStyle(
                                            fontFamily: 'cairo',
                                            color: !studentHomeCubit.isVideos
                                                ? AppColor.honeyYellow
                                                : AppColor.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.infinity,
                      // height: studentHomeCubit.isVideos
                      //     ? MediaQuery.of(context).viewInsets.bottom == 0
                      //         ? studentHomeCubit.courseDetailsModel!.course!.units!.isEmpty
                      //             ? MediaQuery.of(context).size.height *
                      //                     0.5 +
                      //                 60
                      //             : studentHomeCubit.courseDetailsModel!.course!.units!.length *
                      //                     360 +
                      //                 130
                      //         : MediaQuery.of(context).size.height * 0.3
                      //     : MediaQuery.of(context).viewInsets.bottom == 0
                      //         ? 460.0
                      //         : MediaQuery.of(context).size.height * 0.3,
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                      ),
                      child: !studentHomeCubit.isVideos
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        for (var i in studentHomeCubit
                                            .courseDetailsModel!.course!.tags!)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 80.0,
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                color: AppColor.tagsColors[
                                                        studentHomeCubit
                                                            .courseDetailsModel!
                                                            .course!
                                                            .tags!
                                                            .indexOf(i)]
                                                    .withOpacity(0.20),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(8.0),
                                                ),
                                              ),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      i.toString(),
                                                      style: TextStyle(
                                                        color: AppColor
                                                                .tagsColors[
                                                            studentHomeCubit
                                                                .courseDetailsModel!
                                                                .course!
                                                                .tags!
                                                                .indexOf(i)],
                                                        fontSize: 18,
                                                        fontFamily: 'cairo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
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
                                      horizontal: 22.0),
                                  child: Text(
                                    studentHomeCubit
                                        .courseDetailsModel!.course!.title!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColor.black,
                                      fontSize: 20,
                                      fontFamily: 'cairo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        studentHomeCubit.courseDetailsModel!
                                                    .course!.annualPrice ==
                                                0
                                            ? 'FREE'
                                            : '${studentHomeCubit.courseDetailsModel!.course!.annualPrice!} LE',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: AppColor.black,
                                          fontSize: 20,
                                          fontFamily: 'cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        'السعر',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 20,
                                          fontFamily: 'cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 80.0,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 22.0),
                                  child: Text(
                                    'وصف المحتوى',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 20,
                                      fontFamily: 'cairo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 100,
                                    child: Text(
                                      studentHomeCubit
                                          .courseDetailsModel!.course!.desc!,
                                      textAlign: TextAlign.right,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColor.indigoDye,
                                        fontSize: 14,
                                        // fontFamily: 'cairo',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConditionalBuilder(
                                      condition:
                                          state is! SubscribeLoadingState,
                                      fallback: (context) => const Center(
                                          child: CircularProgressIndicator(
                                        color: AppColor.roseMadder,
                                      )),
                                      builder: (context) => CustomElevation(
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
                                                  BorderRadius.circular(21.0)),
                                          onPressed: () {
                                            CacheHelper.sharedPreferences
                                                        .get('token') ==
                                                    null
                                                ? Navigator.pushNamed(
                                                    context,
                                                    '/entry',
                                                  )
                                                :
                                            // studentHomeCubit
                                            //                 .courseDetailsModel!
                                            //                 .course!
                                            //                 .annualPrice !=
                                            //             0
                                            //         ?
                                            Navigator.pushNamed(
                                                        context,
                                                        '/course_subscribe_selection',
                                                        arguments:
                                                            ScreenArguments(
                                                          'id',
                                                          widget.arguments!
                                                              .message,
                                                        ),
                                                      );
                                                    // : studentHomeCubit
                                                    //     .userSubscribeForFree(
                                                    //     subscriptionId: widget
                                                    //         .arguments!.message,
                                                    //   );
                                          },
                                          color: AppColor.roseMadder,
                                          child: const Text(
                                            'أضغط للاشتراك الان',
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
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                )
                              ],
                            )
                          : studentHomeCubit
                                      .courseDetailsModel!.course!.units ==
                                  null
                              ? const Column(
                                  children: [
                                    Center(
                                      child: Text('no data'),
                                    )
                                  ],
                                )
                              : studentHomeCubit.courseDetailsModel!.course!
                                      .units!.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      children: widgetsUnits,
                                    ),
                    ),
                    // const Text('image: '),
                    // Image(
                    //   image: NetworkImage(HomeCubit.get(context)
                    //       .coursesModel!
                    //       .courses!
                    //       .first!
                    //       .image!),
                    //   width: 120.0,
                    //   height: 120.0,
                    // ),
                    // const Text('title: '),
                    // Text(studentHomeCubit.coursesModel!.courses!.first!.title!),
                    // const Text('level id: '),
                    // Text(studentHomeCubit.coursesModel!.courses!.first!.levelId!
                    //     .toString()),
                    // const Text('thumbnail: '),
                    // Image(
                    //   image: NetworkImage(HomeCubit.get(context)
                    //       .coursesModel!
                    //       .courses!
                    //       .first!
                    //       .subnail!),
                    //   width: 120.0,
                    //   height: 120.0,
                    // ),
                  ],
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
// List<Widget> buildListOfUnits() {
//
//
//
//   return widgets;
// }
}
