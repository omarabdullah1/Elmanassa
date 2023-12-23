import 'package:cached_network_image/cached_network_image.dart';
import 'package:edumaster/data/models/course_dashboard_model.dart';
import 'package:edumaster/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/args.dart';
import '../../../styles/colors.dart';
import '../../../widget/flat_button.dart';

class CourseDashboardScreen extends StatelessWidget {
  const CourseDashboardScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);
  final ScreenArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudentHomeCubit()..getCourseDashboard(id: arguments!.message),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          if (studentHomeCubit.courseDashboardModel != null) {
            List<Widget> widgetsUnits = [];
            for (var ele
                in studentHomeCubit.courseDashboardModel!.course!.units!) {
              // Add a SizedBox as a separator, except for the last item
              if (studentHomeCubit.courseDashboardModel!.course!.units!
                      .indexOf(ele) ==
                  0) {
                widgetsUnits.add(
                  const ListTile(
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'محتوى الكورس',
                        style: TextStyle(
                          color: AppColor.indigoDye,
                          fontSize: 20,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }
              widgetsUnits.add(
                ExpandableCard(
                  courseDashboardModelCourseUnits: ele!,
                ),
              );
            }
            // Add a SizedBox as a separator, except for the last item
            if (studentHomeCubit.courseDashboardModel!.course!.units!.length <=
                3) {
              widgetsUnits.add(
                SizedBox(
                  height: (MediaQuery.of(context).size.height -
                      (360 +
                          (studentHomeCubit
                                  .courseDashboardModel!.course!.units!.length *
                              127))),
                ),
              );
            }

            // for (int index = 0;
            //     index < studentHomeCubit.courseDashboardModel!.course!.units!.length;
            //     index++) {
            //   widgetsUnits.add(Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20.0),
            //       color: AppColor.cardGray,
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         children: [
            //           for (var element in studentHomeCubit.courseDashboardModel!.course!
            //               .units![index]!.containers!)
            //             Text(element!.lesson!.title.toString())
            //         ],
            //       ),
            //     ),
            //   ));

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
                              'كورساتي',
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
                                imageUrl:
                                    '$domain/${studentHomeCubit.courseDashboardModel!.course!.thumbnail!}',
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Add your navigation logic here
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

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            for (var i in studentHomeCubit
                                .courseDashboardModel!.course!.tags!)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 80.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: AppColor.tagsColors[studentHomeCubit
                                            .courseDashboardModel!.course!.tags!
                                            .indexOf(i)]
                                        .withOpacity(0.20),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          i.toString(),
                                          style: TextStyle(
                                            color: AppColor.tagsColors[
                                                studentHomeCubit
                                                    .courseDashboardModel!
                                                    .course!
                                                    .tags!
                                                    .indexOf(i)],
                                            fontSize: 18,
                                            fontFamily: 'cairo',
                                            fontWeight: FontWeight.bold,
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
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        studentHomeCubit.courseDashboardModel!.course!.title!,
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
                      height: 30.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                      ),
                      child: studentHomeCubit
                                  .courseDashboardModel!.course!.units ==
                              null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                  child: Text('no data'),
                                )
                              ],
                            )
                          : studentHomeCubit
                                  .courseDashboardModel!.course!.units!.isEmpty
                              ? const SizedBox()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
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

class ExpandableCard extends StatefulWidget {
  const ExpandableCard({
    super.key,
    required this.courseDashboardModelCourseUnits,
  });

  final CourseDashboardModelCourseUnits courseDashboardModelCourseUnits;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        //<-- SEE HERE
        // side: BorderSide(width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.courseDashboardModelCourseUnits.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.indigoDye,
                  fontSize: 22,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 35.0,
                color: AppColor.indigoDye,
              ),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'دروس ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.indigoDye,
                            fontSize: 16,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.courseDashboardModelCourseUnits.containers!
                                  .isNotEmpty
                              ? widget.courseDashboardModelCourseUnits
                                  .containers!.length
                                  .toString()
                              : '0',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColor.indigoDye,
                            fontSize: 16,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.videocam_rounded,
                      size: 16.0,
                      color: AppColor.indigoDye,
                    )
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseDashboardModelCourseUnits.containers!
                              .isNotEmpty
                          ? widget.courseDashboardModelCourseUnits.duration
                              .toString()
                          : 'notime',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColor.indigoDye,
                        fontSize: 16,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    const Icon(
                      Icons.access_time,
                      size: 16.0,
                      color: AppColor.indigoDye,
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
          if (isExpanded)
            for (var ele in widget.courseDashboardModelCourseUnits.containers!)
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/video',
                    arguments: ScreenArguments(
                      ele.lesson!.title.toString(),
                      ele.lesson!.video ??
                          'https://www.youtube.com/watch?v=HQ_ytw58tC4',
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ele!.lesson!.title!.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: AppColor.roseMadder,
                                    // fontSize: 22,
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textDirection: TextDirection.rtl,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            ele.lesson!.videoDuration.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColor.roseMadder,
                              fontSize: 18.0,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.play_circle,
                        size: 60.0,
                        color: AppColor.roseMadder,
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
