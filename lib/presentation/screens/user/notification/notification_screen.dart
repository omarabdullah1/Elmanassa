import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/custom_elevation.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentHomeCubit, StudentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StudentHomeCubit studentHomeCubit =
            context.read<StudentHomeCubit>();
        if (studentHomeCubit.coursesModel != null &&
            studentHomeCubit.bannersModel != null) {
          return Scaffold(
            backgroundColor: AppColor.babyBlue,
            body: RefreshIndicator(
              color: AppColor.indigoDye,
              onRefresh: () async {
                await studentHomeCubit.getNotification();
              },
              child: CacheHelper.sharedPreferences.getString('token') == null
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              Texts.translate(Texts.studentHomePleaseLoginText, context),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          CustomElevation(
                            color: AppColor.roseMadder,
                            radius: 21.0,
                            opacity: 0.25,
                            child: MaterialButton(
                              height: MediaQuery.of(context).size.height * 0.08,
                              minWidth: MediaQuery.of(context).size.width * 0.8,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0)),
                              onPressed: () {
                                CacheHelper.sharedPreferences.clear();
                                Navigator.pushNamed(
                                  context,
                                  Screens.entryScreen,
                                );
                              },
                              color: AppColor.roseMadder,
                              child: Text(
                                Texts.translate(Texts.loginButton, context),
                                textAlign: TextAlign.center,
                                style: TextStyles.loginButtonStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : LayoutBuilder(builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      double height = constraints.maxHeight;
                      return Container(
                        width: width,
                        height: height,
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //         horizontal: 30.0,
                              //         vertical: 20.0,
                              //       ),
                              //       child: Text(
                              //         Texts
                              //             .studentHomeNotificationReceivedRecentlyText,
                              //         textAlign: TextAlign.center,
                              //         style: TextStyles
                              //             .studentHomeNotificationReceivedRecentlyTextStyle,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              studentHomeCubit.notificationModel!.notifications!
                                      .isNotEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: studentHomeCubit
                                          .notificationModel!.notifications!
                                          .map(
                                            (e) => Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: ExpandableNotificationCard(
                                                title: e!.title!,
                                                description: e.desc!,
                                                dateTime: '',
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : Center(
                                      child: Text(
                                        Texts
                                            .translate(Texts
                                            .studentHomeThereIsNoNotificationUntillNowText, context),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    }),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class ExpandableNotificationCard extends StatefulWidget {
  const ExpandableNotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  final String title;
  final String description;
  final String dateTime;

  @override
  State<ExpandableNotificationCard> createState() =>
      _ExpandableNotificationCardState();
}

class _ExpandableNotificationCardState
    extends State<ExpandableNotificationCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: AppColor.indigoDye100,
      shape: RoundedRectangleBorder(
        //<-- SEE HERE
        side: const BorderSide(
          color: AppColor.indigoDye,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.title,
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
          // const Padding(
          //   padding: EdgeInsets.all(8.0),
          // ),
          if (isExpanded)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.description,
                      style: TextStyles.studentHomeNotificationDescriptionStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.dateTime,
                          style:
                              TextStyles.studentHomeNotificationDateTimeStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
