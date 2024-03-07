import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';

import '../../data/local/args.dart';
import '../../data/local/cache_helper.dart';
import '../../data/models/courses_model.dart';
import '../../constants/screens.dart';
import '../../main.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';
import 'custom_elevation.dart';

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
              color: isEnrolled?AppColor.white:AppColor.babyBlue,
              border: Border.all(
                color: AppColor.indigoDye,
                width: 2.5,
              ),
            ),
            child: Column(
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
                              imageUrl: '$domain/${course!.image!}',
                              fit: BoxFit.cover,
                              // progressIndicatorBuilder: (context, url, downloadProgress) =>
                              //     CircularProgressIndicator(value: downloadProgress.progress),
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
                                isEnrolled
                                    ? Navigator.pushNamed(
                                        context,
                                        Screens.courseDashboardScreen,
                                        arguments: ScreenArguments(
                                          'id',
                                          course!.id.toString(),
                                        ),
                                      )
                                    : Navigator.pushNamed(
                                        context,
                                  Screens.videoScreen,
                                        arguments: ScreenArguments(
                                          course!.title.toString(),
                                          course!.introVideo.toString(),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
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
                                            color: AppColor.tagsColors[
                                                course!.tags!.indexOf(j)],
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    course!.title!,
                    textAlign: delegate.currentLocale.languageCode == 'en' ? TextAlign.left : TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: AppColor.black,
                      fontSize: 20,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //TODO make PRICE WIDGET HERE
                course!.annualPrice != null
                    ? course!.annualPrice != 0
                        ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: Text(
                                  '${course!.annualPrice!} LE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.black.withOpacity(0.8),
                                    fontSize: 20,
                                    fontFamily: 'cairo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
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
                              ),
                            ],
                          )
                    : const SizedBox(),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: isEnrolled
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: isEnrolled
                            ? MediaQuery.of(context).size.width * 0.8
                            : MediaQuery.of(context).size.width * 0.4,
                        child: CustomElevation(
                          color: AppColor.roseMadder,
                          radius: 21.0,
                          opacity: 0.25,
                          child: MaterialButton(
                            height: MediaQuery.of(context).size.height * 0.06,
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21.0),
                            ),
                            onPressed: () {
                              //TODO HERE

                              isEnrolled
                                  ? Navigator.pushNamed(
                                      context,
                                Screens.courseDashboardScreen,
                                      arguments: ScreenArguments(
                                        'id',
                                        course!.id.toString(),
                                      ),
                                    )
                                  : CacheHelper.sharedPreferences.getString('token')!=null?Navigator.pushNamed(
                                      context,
                                      Screens.courseSubscriptionScreen,
                                      arguments: ScreenArguments(
                                        'id',
                                        course!.id.toString(),
                                      ),
                                    ):Navigator.pushNamed(
                                context,
                                Screens.entryScreen,
                              );
                            },
                            color: AppColor.roseMadder,
                            child: Text(
                              isEnrolled
                                  ? Texts.translate('studentHomeGoCourseText', context)
                                  : Texts.translate('studentHomeSubscribeNowText', context),
                              textAlign: TextAlign.center,
                              style: TextStyles
                                  .studentHomeGoSubscribeCourseButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                      !isEnrolled
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: CustomElevation(
                                color: AppColor.indigoDye,
                                radius: 21.0,
                                opacity: 0.25,
                                child: MaterialButton(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21.0),
                                  ),
                                  onPressed: () {
                                    //TODO HERE
                                    Navigator.pushNamed(
                                      context,
                                      Screens.courseDetailsScreen,
                                      arguments: ScreenArguments(
                                        'id',
                                        course!.id.toString(),
                                      ),
                                    );
                                  },
                                  color: AppColor.indigoDye,
                                  child: Text(
                                    Texts.translate('studentHomeMoreButtonText', context),
                                    textAlign: TextAlign.center,
                                    style: TextStyles
                                        .studentHomeMoreButtonTextStyle,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
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
