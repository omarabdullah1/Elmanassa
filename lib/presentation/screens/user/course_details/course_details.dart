import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/args.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../generated/assets.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/back_button.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/unit_card_builder.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);
  final ScreenArguments? arguments;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudentHomeCubit()..getCourseDetails(id: arguments!.message),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {
          if (state is SubscribeSuccessState) {
            state.subscribeModel.message.toString() ==
                    Texts.translate(Texts.studentHomeSubscribeModelFailMessageText, context)
                ? AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.scale,
                    title: Texts.translate(Texts.studentHomeRequestFailTitleText, context),
                    desc: state.subscribeModel.message.toString(),
                    // btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Screens.studentHomeScreen,
                        (route) => false,
                      );
                    },
                  ).show()
                : AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.scale,
                    title: Texts.translate(Texts.studentHomeRequestSuccessTitleText, context),
                    desc: state.subscribeModel.message.toString(),
                    // btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Screens.studentHomeScreen,
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
                            Texts.translate(Texts.studentHomeCourseDetailsText, context),
                            style:
                                TextStyles.studentHomeCourseDetailsTextStyle,
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
                                      '$domain/${studentHomeCubit.courseDetailsModel!.course!.thumbnail!}',
                                  fit: BoxFit.cover,
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
                                    Navigator.pushNamed(
                                      context,
                                      Screens.videoScreen,
                                      arguments: ScreenArguments(
                                        studentHomeCubit
                                            .courseDetailsModel!.course!.title!,
                                        studentHomeCubit
                                                    .courseDetailsModel!
                                                    .course!
                                                    .introVideo!,
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
                                            Texts.translate(Texts.studentHomeDetailsText, context),
                                            style: TextStyles
                                                .studentHomeDetailsTextStyle(
                                              studentHomeCubit.isVideos,
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
                                            Texts.translate(Texts.studentHomeVideosText, context),
                                            style: TextStyles
                                                .studentHomeVideosTextStyle(
                                              studentHomeCubit.isVideos,
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
                        width: width,
                        constraints: BoxConstraints(
                          minHeight: height -320,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: !studentHomeCubit.isVideos
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              for (var i in studentHomeCubit
                                                  .courseDetailsModel!
                                                  .course!
                                                  .tags!)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 80.0,
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      color: AppColor
                                                          .tagsColors[
                                                              studentHomeCubit
                                                                  .courseDetailsModel!
                                                                  .course!
                                                                  .tags!
                                                                  .indexOf(i)]
                                                          .withOpacity(0.20),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(8.0),
                                                      ),
                                                    ),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Text(
                                                            i.toString(),
                                                            style: TextStyles
                                                                .studentHomeCourseDetailsTagsStyle(
                                                              studentHomeCubit
                                                                  .courseDetailsModel!
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22.0),
                                        child: Text(
                                          studentHomeCubit.courseDetailsModel!
                                              .course!.title!,
                                          textAlign: TextAlign.center,
                                          style: TextStyles.studentHomeCourseDetailsTitleStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Texts.translate(Texts.studentHomeCourseDetailsCostText, context),
                                          textAlign: TextAlign.center,
                                          style: TextStyles.studentHomeCourseDetailsTitleStyle,
                                        ),
                                        Text(
                                          studentHomeCubit.courseDetailsModel!
                                                      .course!.annualPrice ==
                                                  0
                                              ? 'FREE'
                                              : '${studentHomeCubit.courseDetailsModel!.course!.annualPrice!} LE',
                                          textAlign: TextAlign.center,
                                          style: TextStyles.studentHomeCourseDetailsTitleStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 80.0,
                                  ),
                                   Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22.0),
                                        child: Text(
                                          Texts.translate(Texts.studentHomeCourseDetailsDescriptionText, context),
                                          textAlign: TextAlign.center,
                                          style: TextStyles.studentHomeCourseDetailsTitleStyle,
                                        ),
                                      ),
                                    ],
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
                                        style: TextStyles.studentHomeCourseDetailsDescriptionValueStyle,
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
                                                    BorderRadius.circular(
                                                        21.0)),
                                            onPressed: () {
                                              CacheHelper.sharedPreferences
                                                          .get('token') ==
                                                      null
                                                  ? Navigator.pushNamed(
                                                      context,
                                                      Screens.entryScreen,
                                                    )
                                                  :
                                                  Navigator.pushNamed(
                                                      context,
                                                      Screens
                                                          .courseSubscriptionScreen,
                                                      arguments:
                                                          ScreenArguments(
                                                        'id',
                                                        arguments!.message,
                                                      ),
                                                    );

                                            },
                                            color: AppColor.roseMadder,
                                            child: Text(
                                              Texts.translate(Texts.studentHomeCourseDetailsClickSubscribeText, context),
                                              textAlign: TextAlign.center,
                                              style: TextStyles.studentHomeCourseDetailsClickSubscribeStyle,
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
                                    : Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Column(
                                            children: studentHomeCubit
                                                .courseDetailsModel!
                                                .course!
                                                .units!
                                                .map(
                                                  (e) => UnitCard(
                                                    courseDetailsModelCourseUnits:
                                                        studentHomeCubit
                                                                .courseDetailsModel!
                                                                .course!
                                                                .units![
                                                            studentHomeCubit
                                                                .courseDetailsModel!
                                                                .course!
                                                                .units!
                                                                .indexOf(e)],
                                                  ),
                                                )
                                                .toList()),
                                      ),
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
