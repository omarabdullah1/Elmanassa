import 'package:flutter/material.dart';

import '../../data/local/args.dart';
import '../../data/models/course_details_model.dart';
import '../../main.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';

class UnitCard extends StatefulWidget {
  const UnitCard({
    super.key,
    required this.courseDetailsModelCourseUnits,
  });

  final CourseDetailsModelCourseUnits courseDetailsModelCourseUnits;

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
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
                widget.courseDetailsModelCourseUnits.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.indigoDye,
                  fontSize: 22,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: GestureDetector(
              child: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 35.0,
                color: AppColor.indigoDye,
              ),
              onTap: () {
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
                          Texts
                              .translate(Texts
                              .studentHomeCourseDashboardExpandableCardLessonsText, context),
                          textAlign: TextAlign.center,
                          style: TextStyles.studentHomeCourseDashboardExpandableCardLessonsTextStyle,
                        ),
                        Text(
                          widget.courseDetailsModelCourseUnits.lessons!
                                  .isNotEmpty
                              ? widget
                                  .courseDetailsModelCourseUnits.lessons!.length
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
                      widget.courseDetailsModelCourseUnits.lessons!.isNotEmpty
                          ? widget.courseDetailsModelCourseUnits.duration
                              .toString()
                          : delegate.currentLocale.languageCode == 'en' ? 'notime' : 'لا توجد وقت',
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
            // for (var ele in widget.courseDetailsModelCourseUnits.lessons!)
            //   InkWell(
            //     onTap: () {
            //       Navigator.pushNamed(
            //         context,
            //         '/video',
            //         arguments: ScreenArguments(
            //           ele.title.toString(),
            //           ele.video! ??
            //               'https://www.youtube.com/watch?v=HQ_ytw58tC4',
            //         ),
            //       );
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children: [
            //               FittedBox(
            //                 fit: BoxFit.scaleDown,
            //                 child: Text(
            //                   ele!.title.toString(),
            //                   textAlign: TextAlign.center,
            //                   style: const TextStyle(
            //                     color: AppColor.roseMadder,
            //                     // fontSize: 22,
            //                     fontFamily: 'Tajawal',
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //               Text(
            //                 ele.videoDuration.toString(),
            //                 textAlign: TextAlign.center,
            //                 style: const TextStyle(
            //                   color: AppColor.roseMadder,
            //                   fontSize: 18.0,
            //                   fontFamily: 'Tajawal',
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const Icon(
            //             Icons.play_circle,
            //             size: 60.0,
            //             color: AppColor.roseMadder,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
          for (var ele in widget.courseDetailsModelCourseUnits.lessons!)
            ele.isAccessed != 0
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/video',
                        arguments: ScreenArguments(
                          ele.title.toString(),
                          ele.video ??
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
                                width: MediaQuery.of(context).size.width*0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      ele.title!.toString(),
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
                                ele.videoDuration.toString(),
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
                  )
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.lock,
                            color: AppColor.indigoDye,
                            size: 30.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      ele.title!.toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: AppColor.black,
                                        fontFamily: 'Tajawal',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textDirection: TextDirection.rtl,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      ele
                                          .videoDuration!
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: AppColor.indigoDye,
                                        fontSize: 18.0,
                                        fontFamily: 'Tajawal',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.play_circle,
                                size: 60.0,
                                color: AppColor.indigoDye,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                )
        ],
      ),
    );
  }
}
