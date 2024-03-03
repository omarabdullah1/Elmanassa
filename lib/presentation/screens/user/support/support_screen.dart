import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../main.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../widget/back_button.dart';
import '../../../widget/custom_app_bar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()..getSupport(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          if (studentHomeCubit.supportModel != null) {
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              appBar: CustomAppBar(
                  appBarWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButtonWidget(),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        Texts.translate(Texts.studentHomeSupportScreenText, context),
                        style: TextStyles.studentHomeHomepageStyle,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              )),
              body: RefreshIndicator(
                color: AppColor.indigoDye,
                onRefresh: () async {
                  await studentHomeCubit.getSupport();
                },
                child: LayoutBuilder(builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  double height = constraints.maxHeight;
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 20.0,
                              ),
                              child: Text(
                                Texts.translate(Texts.studentHomeSupportSubtitleText, context),
                                textAlign: delegate.currentLocale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,
                                style: TextStyles
                                    .studentHomeSupportSubtitleTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Card(
                                color: AppColor.indigoDye100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: AppColor.indigoDye,
                                      width: 1.0,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      InkWell(
                                        onTap: () => UrlLauncher.launch(
                                            "tel://${studentHomeCubit.supportModel!.supportInfo![0]!.value!.toString()}"),
                                        child: SizedBox(
                                          width: width * 0.38,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                color: AppColor.honeyYellow,
                                              ),
                                              Text(
                                                studentHomeCubit.supportModel!
                                                    .supportInfo![0]!.value!
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5.0,
                                        ),
                                        child: Container(
                                          color: AppColor.grey.withOpacity(0.2),
                                          width: 1.0,
                                          height: 80.0,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => UrlLauncher.launch(
                                            "mailto://${studentHomeCubit.supportModel!.supportInfo![1]!.value!.toString()}"),

                                        child: SizedBox(
                                          width: width * 0.38,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.mail,
                                                color: AppColor.roseMadder,
                                              ),
                                              Text(
                                                studentHomeCubit.supportModel!
                                                    .supportInfo![1]!.value!
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Card(
                                color: AppColor.indigoDye100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: AppColor.indigoDye,
                                      width: 1.0,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      InkWell(
                                        onTap: () => UrlLauncher.launch(
                                            "https://wa.me/${studentHomeCubit.supportModel!.supportInfo![2]!.value!.toString()}"),
                                        child: SizedBox(
                                          width: width * 0.38,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.whatsapp,
                                                color: AppColor.green,
                                              ),
                                              Text(studentHomeCubit.supportModel!
                                                  .supportInfo![2]!.value!
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Container(
                                          color: AppColor.grey.withOpacity(0.2),
                                          width: 1.0,
                                          height: 80.0,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => UrlLauncher.launch(
                                            "https://www.facebook.com/${studentHomeCubit.supportModel!.supportInfo![3]!.value!.toString()}"),

                                        child: SizedBox(
                                          width: width * 0.38,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.facebook,
                                                color: AppColor.indigoDye,
                                              ),
                                              Text(studentHomeCubit.supportModel!
                                                  .supportInfo![3]!.value!
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Card(
                                color: AppColor.indigoDye100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: AppColor.indigoDye,
                                      width: 1.0,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.access_time_filled_rounded,
                                          color: AppColor.indigoDye,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          studentHomeCubit.supportModel!
                                              .supportInfo![4]!.value!
                                              .toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: studentHomeCubit
                                  .supportModel!.supportInfo!
                                  .map((e) {
                                if (studentHomeCubit.supportModel!.supportInfo!
                                        .indexOf(e) >
                                    4) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                    ),
                                    child: Card(
                                      color: AppColor.indigoDye100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
                                            color: AppColor.indigoDye,
                                            width: 1.0,
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
                                              child: Icon(
                                                Icons.circle_rounded,
                                                color: AppColor.indigoDye,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                studentHomeCubit
                                                    .supportModel!
                                                    .supportInfo![
                                                        studentHomeCubit
                                                            .supportModel!
                                                            .supportInfo!
                                                            .indexOf(e)]!
                                                    .value!
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyles.studentHomeNotificationTitleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.description,
                          style: TextStyles
                              .studentHomeNotificationDescriptionStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
