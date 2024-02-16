import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:edumaster/data/local/args.dart';
import 'package:edumaster/presentation/widget/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/flat_button.dart';
import '../../../widget/paymet_code_box.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {
          if (state is GetQuizDetailsErrorState) {
            context
                .read<StudentHomeCubit>()
                .changeQuizBoxColor(AppColor.roseMadder);
            context
                .read<StudentHomeCubit>()
                .changeQuizBoxIcon(Icons.error_outline);
            context.read<StudentHomeCubit>().changeQuizButtonState(false);
          } else if (state is GetQuizDetailsSuccessState) {
            context.read<StudentHomeCubit>().changeQuizBoxColor(AppColor.green);
            context.read<StudentHomeCubit>().changeQuizBoxIcon(Icons.check);
            context.read<StudentHomeCubit>().changeQuizButtonState(true);
          }
        },
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
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
                        Texts.studentHomeQuizScreenText,
                        style: TextStyles.studentHomeHomepageStyle,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                      vertical: 20.0,
                                    ),
                                    child: Text(
                                      'أدخل كود الاختبار',
                                      textAlign: TextAlign.center,
                                      style: TextStyles
                                          .studentHomeQuizScreenTitleTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: Row(
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ConditionalBuilder(
                                          condition: state
                                              is! GetQuizDetailsLoadingState,
                                          fallback: (context) => const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColor.roseMadder,
                                            ),
                                          ),
                                          builder: (context) => CustomElevation(
                                            color: AppColor.carosalBG,
                                            radius: 20.0,
                                            opacity: 0.25,
                                            child: MaterialButton(
                                              disabledColor: AppColor.carosalBG,
                                              height: 35.0,
                                              minWidth: 80.0,
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              onPressed: studentHomeCubit
                                                      .quizButtonState
                                                  ? null
                                                  : () {
                                                      if (studentHomeCubit
                                                          .quizCodeController
                                                          .text
                                                          .isNotEmpty) {
                                                        studentHomeCubit
                                                            .changeQuizBoxIcon(
                                                          null,
                                                        );
                                                        studentHomeCubit
                                                            .startQuizByCode(
                                                          code: studentHomeCubit
                                                              .quizCodeController
                                                              .text,
                                                        );
                                                      } else {
                                                        studentHomeCubit
                                                            .changeQuizBoxColor(
                                                          AppColor.honeyYellow,
                                                        );
                                                        studentHomeCubit
                                                            .changeQuizBoxIcon(
                                                          Icons
                                                              .warning_amber_rounded,
                                                        );
                                                      }
                                                    },
                                              color: AppColor.roseMadder,
                                              child: Text(
                                                Texts
                                                    .studentHomeCourseSubscribeScreenPaymentConfirmButtonText,
                                                textAlign: TextAlign.center,
                                                style: TextStyles
                                                    .studentHomeCourseDetailsClickSubscribeCheckStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 40.0,
                                      child: CustomFormField(
                                        controller:
                                            studentHomeCubit.quizCodeController,
                                        type: TextInputType.text,
                                        borderRadius: 10.0,
                                        onSubmit: (s) {},
                                        suffixIcon: studentHomeCubit
                                                    .quizCodeIcon !=
                                                null
                                            ? Icon(
                                                studentHomeCubit.quizCodeIcon,
                                                color: studentHomeCubit
                                                    .quizBoxColor,
                                              )
                                            : null,
                                        baseColor:
                                            studentHomeCubit.quizBoxColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              ConditionalBuilder(
                                condition: studentHomeCubit.quizButtonState,
                                builder: (context) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomElevation(
                                      color: AppColor.carosalBG,
                                      radius: 20.0,
                                      opacity: 0.25,
                                      child: MaterialButton(
                                        disabledColor: AppColor.carosalBG,
                                        height: 35.0,
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Screens.quizHomeScreen,
                                              arguments: ScreenArguments(
                                                'id',
                                                studentHomeCubit
                                                    .quizModel!.quiz!.id!
                                                    .toString(),
                                              ));
                                        },
                                        color: AppColor.roseMadder,
                                        child: Text(
                                          Texts
                                              .studentHomeQuizCodeScreenGoToQuizButtonText,
                                          textAlign: TextAlign.center,
                                          style: TextStyles
                                              .studentHomeCourseDetailsClickSubscribeCheckStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                fallback: (context) => const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
