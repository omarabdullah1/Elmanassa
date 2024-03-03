import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/back_button.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/flat_button.dart';

class DegreesScreen extends StatelessWidget {
  const DegreesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()..getQuizsDegrees(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          if (studentHomeCubit.quizsDegreesModel != null) {
            return Scaffold(
              appBar: CustomAppBar(
                  appBarWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButtonWidget(),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        Texts.translate(Texts.studentHomeDegreesScreenText, context),
                        style: TextStyles.studentHomeHomepageStyle,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              )),
              backgroundColor: AppColor.babyBlue,
              body: Builder(
                builder: (context) => SafeArea(
                  child: RefreshIndicator(
                    color: AppColor.indigoDye,
                    onRefresh: () async {
                      // await Future.wait(
                      // [studentHomeCubit.getCourses(), studentHomeCubit.getBanners()]);
                      await studentHomeCubit.getQuizsDegrees();
                    },
                    child: LayoutBuilder(builder: (context, constraints) {
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
                              studentHomeCubit.quizsDegreesModel!
                                      .studentQuizzes!.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: studentHomeCubit
                                          .quizsDegreesModel!.studentQuizzes!
                                          .map(
                                            (e) => Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: DegreesCard(
                                                title: e!.title!,
                                                description:
                                                    e.degree!.toString(),
                                                duration:
                                                    e.quizDuration.toString(),
                                                quizDegree: e.degree!,
                                                myDegree: e.grade!,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : Column(
                                      children: [
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Center(
                                          child: Text(
                                            Texts
                                                .translate(Texts
                                                .studentHomeQuizThereIsNoDegreesUntilNowText, context),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
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
      ),
    );
  }
}

class DegreesCard extends StatefulWidget {
  const DegreesCard({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.quizDegree,
    required this.myDegree,
  });

  final String title;
  final String description;
  final String duration;
  final int quizDegree;
  final int myDegree;

  @override
  State<DegreesCard> createState() => _DegreesCardState();
}

class _DegreesCardState extends State<DegreesCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: AppColor.indigoDye100,
      shape: RoundedRectangleBorder(
        //<-- SEE HERE
        side: const BorderSide(
          color: AppColor.indigoDye,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.start,
                          style: TextStyles
                              .studentHomeCourseDashboardCourseTitleStyle,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 25.0,
                              decoration: BoxDecoration(
                                color: AppColor.indigoDye.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(
                                  child: Text(
                                    '${((widget.myDegree / widget.quizDegree) * 100).toStringAsFixed(2)}%',
                                    style: TextStyles
                                        .studentHomeQuizDegreeSuccessFailBoxTextStyle(
                                      AppColor.indigoDye,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 25.0,
                              decoration: BoxDecoration(
                                color: ((widget.myDegree / widget.quizDegree) *
                                            100) >=
                                        50
                                    ? AppColor.green.withOpacity(0.2)
                                    : AppColor.roseMadder.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(
                                  child: Text(
                                    ((widget.myDegree / widget.quizDegree) *
                                                100) >=
                                            50
                                        ? 'ناجح'
                                        : 'راسب',
                                    style: TextStyles
                                        .studentHomeQuizDegreeSuccessFailBoxTextStyle(
                                            ((widget.myDegree /
                                                            widget.quizDegree) *
                                                        100) >=
                                                    50
                                                ? AppColor.green
                                                : AppColor.roseMadder),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.start,
                      style:
                          TextStyles.studentHomeQuizDegreeDescriptionTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.duration,
                              style:
                                  TextStyles.studentHomeQuizDegreeDateTimeStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            // ),
          ],
        ),
      ),
    );
  }
}
