import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/args.dart';
import '../../../../constants/screens.dart';
import '../../../../data/models/course_dashboard_model.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/back_button.dart';
import '../../../widget/custom_app_bar.dart';
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
        listener: (context, state) {
          // if(state is GetCourseDashboardSuccessState){
          //   for(var ele in state.courseDashboardModel.course!.units!) {
          //     for(var ele1 in ele!.containers!)
          //     print(ele1!.type.toString());
          //     print(ele!.title.toString());
          //   }
          // }
        },
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          if (studentHomeCubit.courseDashboardModel != null) {
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              appBar: CustomAppBar(
                appBarWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 45.0,
                          width: 45.0,
                          child: Image.asset(
                            Assets.iconImgPerson,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Center(
                          child: Text(
                            studentHomeCubit
                                .courseDashboardModel!.course!.title!,
                            style: const TextStyle(
                              fontFamily: 'cairo',
                              color: AppColor.indigoDye,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const BackButtonWidget(),
                    ],
                  ),
                ),
              ),
              body: LayoutBuilder(builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                return SingleChildScrollView(
                  child: Column(
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
                                GestureDetector(
                                  onTap: () {
                                    // Add your navigation logic here
                                    Navigator.pushNamed(
                                      context,
                                      Screens.videoScreen,
                                      arguments: ScreenArguments(
                                        studentHomeCubit
                                            .courseDashboardModel!.course!.title
                                            .toString(),
                                        studentHomeCubit.courseDashboardModel!
                                                .course!.introVideo ??
                                            Texts.translate(
                                                Texts
                                                    .studentHomeCourseDashboardVideoPathText,
                                                context),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.play_circle,
                                    color: AppColor.roseMadder,
                                    size: 80.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var i in studentHomeCubit
                                      .courseDashboardModel!.course!.tags!)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 80.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: AppColor.tagsColors[
                                                  studentHomeCubit
                                                      .courseDashboardModel!
                                                      .course!
                                                      .tags!
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
                                                style: TextStyles
                                                    .studentHomeCourseDetailsTagsStyle(
                                                  studentHomeCubit
                                                      .courseDashboardModel!
                                                      .course!
                                                      .tags!
                                                      .indexOf(i),
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
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Text(
                              studentHomeCubit
                                  .courseDashboardModel!.course!.title!,
                              textAlign: TextAlign.center,
                              style: TextStyles
                                  .studentHomeCourseDashboardCourseTitleStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: width,
                        constraints: BoxConstraints(
                          minHeight: height -280,
                        ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text('no data'),
                                  )
                                ],
                              )
                            : studentHomeCubit.courseDashboardModel!.course!
                                    .units!.isEmpty
                                ? const SizedBox()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        ListTile(
                                          title: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              Texts.translate(
                                                  Texts
                                                      .studentHomeCourseDashboardCourseDetailsText,
                                                  context),
                                              style: TextStyles
                                                  .studentHomeCourseDashboardCourseDetailsTextStyle,
                                            ),
                                          ),
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Column(
                                            children: studentHomeCubit
                                                .courseDashboardModel!
                                                .course!
                                                .units!
                                                .map(
                                                  (e) => ExpandableCard(
                                                    courseDashboardModelCourseUnits:
                                                        e,
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        )
                                      ]),
                      ),
                    ],
                  ),
                );
              }),
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
        borderRadius: BorderRadius.circular(35),
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
                style: TextStyles.studentHomeCourseDashboardCourseTitleStyle,
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
                        Text(
                          Texts.translate(
                              Texts
                                  .studentHomeCourseDashboardExpandableCardLessonsText,
                              context),
                          textAlign: TextAlign.center,
                          style: TextStyles
                              .studentHomeCourseDashboardExpandableCardLessonsTextStyle,
                        ),
                        Text(
                          widget.courseDashboardModelCourseUnits.containers!
                                  .isNotEmpty
                              ? widget.courseDashboardModelCourseUnits
                                  .containers!.length
                                  .toString()
                              : '0',
                          textAlign: TextAlign.center,
                          style: TextStyles
                              .studentHomeCourseDashboardExpandableCardLessonsTextStyle,
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
                          : delegate.currentLocale.languageCode == 'en'
                              ? 'notime'
                              : 'لا توجد وقت',
                      textAlign: TextAlign.center,
                      style: TextStyles
                          .studentHomeCourseDashboardExpandableCardLessonsTextStyle,
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
              ele.type == 'quiz'
                  ? InkWell(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.scale,
                          title: 'Confirm',
                          desc: 'Do You want to Confirm Entering the Quiz',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            Navigator.pushNamed(
                              context,
                              Screens.quizHomeScreen,
                              arguments: ScreenArguments(
                                ele.type.toString(),
                                ele.quizId.toString(),
                              ),
                            );
                          },
                        ).show();
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ele.quiz!.title!,
                                        textAlign: TextAlign.start,
                                        style: TextStyles
                                            .studentHomeCourseDashboardExpandableCardQuesTextStyle,
                                        textDirection: TextDirection.rtl,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                // Text(
                                //   ele.lesson!.videoDuration.toString(),
                                //   textAlign: TextAlign.center,
                                //   style: const TextStyle(
                                //     color: AppColor.roseMadder,
                                //     fontSize: 18.0,
                                //     fontFamily: 'Tajawal',
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                            const Icon(
                              Icons.quiz,
                              size: 60.0,
                              color: AppColor.roseMadder,
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTapUp: (_) {
                        Navigator.pushNamed(
                          context,
                          Screens.videoScreen,
                          arguments: ScreenArguments(
                            ele.lesson!.title.toString(),
                            ele.lesson!.video ??
                                Texts.translate(
                                    Texts
                                        .studentHomeCourseDashboardVideoPathText,
                                    context),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ele.lesson!.title!.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyles
                                            .studentHomeCourseDashboardCourseLessonTitleStyle,
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
                                  style: TextStyles
                                      .studentHomeCourseDashboardExpandableCardVideoDurationTextStyle,
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
