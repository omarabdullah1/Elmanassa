import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../data/local/args.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/paymet_code_box.dart';
import '../../../widget/toast.dart';

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({Key? key, this.arguments}) : super(key: key);
  final ScreenArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()
        ..getQuizDetails(id: arguments!.message)
        ..getStartedQuiz(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          if (studentHomeCubit.quizModel != null) {
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              body: Builder(
                builder: (context) => SafeArea(
                  child: RefreshIndicator(
                    color: AppColor.indigoDye,
                    onRefresh: () async {
                      // await Future.wait(
                      // [studentHomeCubit.getCourses(), studentHomeCubit.getBanners()]);
                      // await studentHomeCubit.getNotification();
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
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
                          child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: studentHomeCubit.quizController,
                            onPageChanged: (int index) {
                              if (index == 0) {
                                studentHomeCubit.isQuizFirst = true;
                                studentHomeCubit.changeQuizState();
                              } else {
                                studentHomeCubit.isQuizFirst = false;
                                studentHomeCubit.changeQuizState();
                              }
                              if (index ==
                                  studentHomeCubit
                                          .quizModel!.quiz!.questions!.length -
                                      1) {
                                studentHomeCubit.isQuizLast = true;
                                studentHomeCubit.changeQuizState();
                              } else {
                                studentHomeCubit.isQuizLast = false;
                                studentHomeCubit.changeQuizState();
                              }
                            },
                            itemBuilder: (context, index) => QuizQuestion(
                              index: index,
                              state: state,
                            ),
                            itemCount: studentHomeCubit
                                .quizModel!.quiz!.questions!.length,
                          ),
                        );
                      },
                    ),
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

class QuizQuestion extends StatelessWidget {
  final int index;
  final state;

  const QuizQuestion({
    super.key,
    required this.index,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Countdown(
                  seconds: context
                      .read<StudentHomeCubit>()
                      .convertTimeStringToComponents(context
                          .read<StudentHomeCubit>()
                          .quizModel!
                          .quiz!
                          .quizDuration!),
                  build: (BuildContext context, double time) => Text(
                    '${time ~/ 3600}:${(time % 3600) ~/ 60}:${time % 60}',
                  ),
                  interval: const Duration(seconds: 1),
                  onFinished: () {
                    print('Timer is done!');
                    Navigator
                        .pushNamedAndRemoveUntil(
                      context,
                      Screens
                          .studentHomeScreen,
                          (route) => false,
                    );
                  },
                )
              ],
            ),
            Text(
              context
                  .read<StudentHomeCubit>()
                  .quizModel!
                  .quiz!
                  .questions![index]!
                  .title!,
              textAlign: TextAlign.start,
              style: TextStyles.studentHomeQuizScreenQuesTitleTextStyle,
            ),
            // Text(
            //   context
            //       .read<StudentHomeCubit>()
            //       .quizModel!
            //       .quiz!
            //       .questions![index]!
            //       .desc!,
            //   textAlign: TextAlign.start,
            //   style: TextStyles.studentHomeQuizScreenQuesDetailsTextStyle,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: context
                  .read<StudentHomeCubit>()
                  .quizModel!
                  .quiz!
                  .questions![index]!
                  .choices!
                  .map(
                    (e) => ListTile(
                      title: Text(
                        e.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyles
                            .studentHomeQuizScreenQuesDetailsTextStyle,
                      ),
                      leading: Radio(
                        value: context
                            .read<StudentHomeCubit>()
                            .quizModel!
                            .quiz!
                            .questions![index]!
                            .choices!
                            .indexOf(e),
                        groupValue: context
                            .read<StudentHomeCubit>()
                            .quizQuestionSelectedValues[index],
                        onChanged: (value) {
                          print(context
                              .read<StudentHomeCubit>()
                              .quizQuestionSelectedValues);
                          print(value);
                          context
                              .read<StudentHomeCubit>()
                              .changeQuizAnswerState(index, value!);
                          print(context
                              .read<StudentHomeCubit>()
                              .quizQuestionSelectedValues);
                          print(value);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  MaterialButton(
                    disabledColor: AppColor.carosalBG,
                    height: 35.0,
                    minWidth: 100.0,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    onPressed: !context.read<StudentHomeCubit>().isQuizFirst
                        ? () {
                            context
                                .read<StudentHomeCubit>()
                                .quizController
                                .previousPage(
                                  duration: const Duration(
                                    milliseconds: 750,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                          }
                        : null,
                    color: AppColor.honeyYellow,
                    child: Text(
                      Texts.studentHomeQuizPreviousButtonText,
                      textAlign: TextAlign.center,
                      style: TextStyles.studentHomeQuizPreviousButtonTextStyle,
                    ),
                  ),
                  const Spacer(),
                  ConditionalBuilder(
                    condition: state is! SubmitQuizQuesLoadingState,
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    builder: (context) {
                      return MaterialButton(
                        disabledColor: AppColor.carosalBG,
                        height: 35.0,
                        minWidth: 100.0,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () async {
                          String quizID = context
                              .read<StudentHomeCubit>()
                              .quizModel!
                              .quiz!
                              .id!
                              .toString();
                          if (context
                              .read<StudentHomeCubit>()
                              .quizQuestionSelectedValues
                              .containsKey(index)) {
                            if (context.read<StudentHomeCubit>().isQuizLast) {
                              print(context
                                  .read<StudentHomeCubit>()
                                  .quizQuestionSelectedValues);
                              await context
                                  .read<StudentHomeCubit>()
                                  .submitQuizQuestion(
                                    quizID: context
                                        .read<StudentHomeCubit>()
                                        .quizModel!
                                        .quiz!
                                        .id!
                                        .toString(),
                                    quesID: context
                                        .read<StudentHomeCubit>()
                                        .quizModel!
                                        .quiz!
                                        .questions![index]!
                                        .id!
                                        .toString(),
                                    quesAnswer: context
                                        .read<StudentHomeCubit>()
                                        .quizModel!
                                        .quiz!
                                        .questions![index]!
                                        .choices![context
                                            .read<StudentHomeCubit>()
                                            .quizQuestionSelectedValues[index]!]
                                        .toString(),
                                  )
                                  .then((value) => showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColor.roseMadder,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColor.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: AppColor.black
                                                      .withOpacity(0.4),
                                                  blurRadius: 35,
                                                  offset: const Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: AppColor
                                                      .roseMadder
                                                      .withOpacity(0.1),
                                                  child: const FaIcon(
                                                    FontAwesomeIcons.question,
                                                    color: AppColor.roseMadder,
                                                  ),
                                                ),
                                                Text(
                                                  Texts
                                                      .studentHomeQuizCodeScreenSendTheQuizMessageText,
                                                  style: TextStyles
                                                      .studentHomeProfilePersonalAccountTextStyle,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    15.0,
                                                  ),
                                                  child: MaterialButton(
                                                    disabledColor:
                                                        AppColor.carosalBG,
                                                    height: 35.0,
                                                    minWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    elevation: 0.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      StudentHomeCubit()
                                                          .submitQuiz(
                                                        quizID: quizID,
                                                      )
                                                          .then((value) {
                                                        Navigator
                                                            .pushNamedAndRemoveUntil(
                                                          context,
                                                          Screens
                                                              .studentHomeScreen,
                                                          (route) => false,
                                                        );
                                                      });
                                                    },
                                                    color: AppColor.roseMadder,
                                                    child: Text(
                                                      Texts
                                                          .studentHomeQuizCodeScreenSendTheQuizButtonText,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyles
                                                          .studentHomeQuizPreviousButtonTextStyle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                              // submit(context);
                            } else {
                              print(context
                                  .read<StudentHomeCubit>()
                                  .quizQuestionSelectedValues);
                              context
                                  .read<StudentHomeCubit>()
                                  .quizController
                                  .nextPage(
                                    duration: const Duration(
                                      milliseconds: 750,
                                    ),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                              context
                                  .read<StudentHomeCubit>()
                                  .submitQuizQuestion(
                                    quizID: context
                                        .read<StudentHomeCubit>()
                                        .quizModel!
                                        .quiz!
                                        .id!
                                        .toString(),
                                    quesID: context
                                        .read<StudentHomeCubit>()
                                        .quizModel!
                                        .quiz!
                                        .questions![index]!
                                        .id!
                                        .toString(),
                                    quesAnswer: context
                                        .read<StudentHomeCubit>()
                                        .quizModel!
                                        .quiz!
                                        .questions![index]!
                                        .choices![context
                                            .read<StudentHomeCubit>()
                                            .quizQuestionSelectedValues[index]!]
                                        .toString(),
                                  );
                            }
                          } else {
                            fToast.init(context);
                            showToast('please select value');
                          }
                        },
                        color: AppColor.roseMadder,
                        child: Text(
                          context.read<StudentHomeCubit>().isQuizLast
                              ? Texts.studentHomeQuizConfirmButtonText
                              : Texts.studentHomeQuizNextButtonText,
                          textAlign: TextAlign.center,
                          style:
                              TextStyles.studentHomeQuizConfirmButtonTextStyle,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
