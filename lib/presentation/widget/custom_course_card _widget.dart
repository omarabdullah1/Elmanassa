
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/local/args.dart';
import '../../data/models/courses_model.dart';
import '../styles/colors.dart';
import 'custom_elevation.dart';

class CustomCourseWidget extends StatelessWidget {
  final String domain;
  final CoursesModelCourses? course;
  final bool isEnrolled;

  const CustomCourseWidget({
    Key? key,
    required this.domain,
    required this.course,
    required this.isEnrolled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevation(
          radius: 20.0,
          opacity: 0.6,
          color: AppColor.indigoDye,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColor.babyBlue,
              border: Border.all(
                color: AppColor.indigoDye,
                width: 2.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Container(
                        width: double.infinity,
                        height: 150.0,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage('$domain/${course!.thumbnail!}'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              AppColor.black.withOpacity(0.2),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Handle video playback
                            // Navigator.pushNamed(
                            //   context,
                            //   '/video',
                            //   arguments: ScreenArguments(
                            //     course.title!,
                            //     bloc.coursesModel!.courses!.units!.first!
                            //         .lessons!.isNotEmpty
                            //         ? bloc.courseDetailsModel!.course!.units!
                            //         .first!.lessons!.first!.video!
                            //         : 'https://www.youtube.com/watch?v=HQ_ytw58tC4',
                            //   ),
                            // );
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.roseMadder,
                              border: Border.all(
                                color: AppColor.white,
                                width: 3.0,
                              ),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: AppColor.white,
                            ),
                          ),
                          iconSize: 40.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (var j in course!.tags!)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: AppColor
                                  .tagsColors[course!.tags!.indexOf(j)]
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
                                    j.toString(),
                                    style: TextStyle(
                                      color: AppColor
                                          .tagsColors[course!.tags!.indexOf(j)],
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    course!.title!,
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
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevation(
                      color: AppColor.roseMadder,
                      radius: 21.0,
                      opacity: 0.25,
                      child: MaterialButton(
                        height: MediaQuery.of(context).size.height * 0.06,
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0),
                        ),
                        onPressed: () {
                          isEnrolled
                              ? Navigator.pushNamed(
                                  context,
                                  '/course_dashboard',
                                  arguments: ScreenArguments(
                                    'id',
                                    course!.id.toString(),
                                  ),
                                )
                              : Navigator.pushNamed(
                                  context,
                                  '/course_details',
                                  arguments: ScreenArguments(
                                    'id',
                                    course!.id.toString(),
                                  ),
                                );
                        },
                        color: AppColor.roseMadder,
                        child: const Text(
                          'أذهب للكورس',
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
                const SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}


class CustomMyCourseWidget extends StatelessWidget {
  final String domain;
  final CoursesModelCourses? course;
  final bool isEnrolled;

  const CustomMyCourseWidget({
    Key? key,
    required this.domain,
    required this.course,
    required this.isEnrolled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevation(
          radius: 20.0,
          opacity: 0.6,
          color: AppColor.indigoDye,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColor.babyBlue,
              border: Border.all(
                color: AppColor.indigoDye,
                width: 2.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: '$domain/${course!.thumbnail!}',
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
                          isEnrolled
                              ? Navigator.pushNamed(
                            context,
                            '/course_dashboard',
                            arguments: ScreenArguments(
                              'id',
                              course!.id.toString(),
                            ),
                          )
                              : Navigator.pushNamed(
                            context,
                            '/course_details',
                            arguments: ScreenArguments(
                              'id',
                              course!.id.toString(),
                            ),
                          );
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.roseMadder,
                            border: Border.all(
                              color: AppColor.white,
                              width: 3.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: AppColor.white,
                          ),
                        ),
                        iconSize: 40.0,
                      ),
                    ],
                  ),
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
                        for (var j in course!.tags!)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: AppColor
                                    .tagsColors[course!.tags!.indexOf(j)]
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
                                      j.toString(),
                                      style: TextStyle(
                                        color: AppColor
                                            .tagsColors[course!.tags!.indexOf(j)],
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
                    course!.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColor.black,
                      fontSize: 20,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //TODO make PRICE WIDGET HERE
                course!.annualPrice!=null?course!.annualPrice!=0?Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    '${course!.annualPrice!} LE',
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: AppColor.black.withOpacity(0.8),
                      fontSize: 20,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ): Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    'FREE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.8),
                      fontSize: 20,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ):const SizedBox(),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevation(
                      color: AppColor.roseMadder,
                      radius: 21.0,
                      opacity: 0.25,
                      child: MaterialButton(
                        height: MediaQuery.of(context).size.height * 0.06,
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0),
                        ),
                        onPressed: () {
                          isEnrolled
                              ? Navigator.pushNamed(
                                  context,
                                  '/course_dashboard',
                                  arguments: ScreenArguments(
                                    'id',
                                    course!.id.toString(),
                                  ),
                                )
                              : Navigator.pushNamed(
                                  context,
                                  '/course_details',
                                  arguments: ScreenArguments(
                                    'id',
                                    course!.id.toString(),
                                  ),
                                );
                        },
                        color: AppColor.roseMadder,
                        child: Text(
                          isEnrolled?'إذهب للكورس':'تفاصيل الكورس',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                const SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}

