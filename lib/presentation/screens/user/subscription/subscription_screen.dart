import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/args.dart';
import '../../../../constants/screens.dart';
import '../../../../generated/assets.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/back_button.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/paymet_code_box.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({
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
            if (state.subscribeModel.message.toString() ==
                'Faild to subscribe course, may be the subscription package exceeded the limit') {
              context
                  .read<StudentHomeCubit>()
                  .changePaymentBoxColor(AppColor.roseMadder);
              context
                  .read<StudentHomeCubit>()
                  .changePaymentBoxIcon(Icons.error_outline);
              context.read<StudentHomeCubit>().changePaymentButtonState(false);
            } else {
              context
                  .read<StudentHomeCubit>()
                  .changePaymentBoxColor(AppColor.green);
              context
                  .read<StudentHomeCubit>()
                  .changePaymentBoxIcon(Icons.check);
              context.read<StudentHomeCubit>().changePaymentButtonState(true);
            }
          } else if (state is SubscribeErrorState) {
            context
                .read<StudentHomeCubit>()
                .changePaymentBoxColor(AppColor.roseMadder);
            context
                .read<StudentHomeCubit>()
                .changePaymentBoxIcon(Icons.error_outline);
            context.read<StudentHomeCubit>().changePaymentButtonState(false);
          }
        },
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
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
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 35.0,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: Text(
                              Texts.translate(Texts.studentHomeCourseSubscribeScreenTitleText, context),
                              style: TextStyles.studentHomeHomepageStyle,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                  color: AppColor.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Center(
                                    child: Text(
                                      studentHomeCubit
                                          .courseDetailsModel!.course!.title!,
                                      style: TextStyles
                                          .studentHomeCourseSubscriptionCourseTitleStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Text(
                            Texts
                                .translate(Texts
                                .studentHomeCourseSubscribeScreenEnterPaymentCodeText, context),
                            style: TextStyles
                                .studentHomeCourseSubscriptionEnterPaymentCodeStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConditionalBuilder(
                                condition: state is! SubscribeLoadingState,
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
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onPressed: studentHomeCubit.paymentButtonState
                                        ? null
                                        : () {
                                            if (studentHomeCubit
                                                .paymentCodeController
                                                .text
                                                .isNotEmpty) {
                                              studentHomeCubit
                                                  .changePaymentBoxIcon(
                                                null,
                                              );
                                              studentHomeCubit
                                                  .userSubscribeByCode(
                                                subscriptionCode:
                                                    studentHomeCubit
                                                        .paymentCodeController
                                                        .text
                                                        .toString(),
                                              );
                                            } else {
                                              studentHomeCubit
                                                  .changePaymentBoxColor(
                                                      AppColor.honeyYellow);
                                              studentHomeCubit
                                                  .changePaymentBoxIcon(
                                                Icons.warning_amber_rounded,
                                              );
                                            }
                                          },
                                    color: AppColor.roseMadder,
                                    child: Text(
                                      Texts
                                          .translate(Texts
                                          .studentHomeCourseSubscribeScreenPaymentConfirmButtonText, context),
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: CustomFormField(
                              controller:
                                  studentHomeCubit.paymentCodeController,
                              type: TextInputType.text,
                              borderRadius: 10.0,
                              onSubmit: (s) {},
                              suffixIcon: studentHomeCubit.paymentCodeIcon !=
                                      null
                                  ? Icon(
                                      studentHomeCubit.paymentCodeIcon,
                                      color: studentHomeCubit.paymentBoxColor,
                                    )
                                  : null, baseColor: studentHomeCubit.paymentBoxColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: width,
                      constraints: BoxConstraints(
                        minHeight: height -350,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Text(
                                  Texts
                                      .translate(Texts
                                      .studentHomeCourseSubscribeScreenPaymentDetailsText, context),
                                  textAlign: TextAlign.center,
                                  style: TextStyles
                                      .studentHomeCourseSubscribeScreenPaymentDetailsTextStyle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 35.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              decoration: BoxDecoration(
                                color: AppColor.cardGray,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 20.0,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Texts
                                                  .translate(Texts
                                                  .studentHomeCourseSubscribeScreenTotalCostText, context),
                                              style: TextStyles
                                                  .studentHomeCourseSubscribeScreenTotlaCostTextStyle,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                '${studentHomeCubit.courseDetailsModel!.course!.annualPrice}  EGP',
                                                style: TextStyles
                                                    .studentHomeCourseSubscribeScreenTotlaCostValueStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Texts
                                                  .translate(Texts
                                                  .studentHomeCourseSubscribeScreenPaymentCodeText, context),
                                              style: TextStyles
                                                  .studentHomeCourseSubscribeScreenTotlaCostTextStyle,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                '-${!studentHomeCubit.paymentButtonState?0:studentHomeCubit.courseDetailsModel!.course!.annualPrice}  EGP',
                                                style: TextStyles
                                                    .studentHomeCourseSubscribeScreenTotlaCostValueStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Texts
                                              .translate(Texts
                                              .studentHomeCourseSubscribeScreenTotalCostText, context),
                                          style: TextStyles
                                              .studentHomeCourseSubscribeScreenTotlaCostTextStyle,
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                            '${!studentHomeCubit.paymentButtonState?studentHomeCubit.courseDetailsModel!.course!.annualPrice:0}  EGP',
                                            style: TextStyles
                                                .studentHomeCourseSubscribeScreenTotlaCostValueStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevation(
                                color: AppColor.carosalBG,
                                radius: 20.0,
                                opacity: 0.25,
                                child: MaterialButton(
                                  disabledColor: AppColor.carosalBG,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.88,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  onPressed: !studentHomeCubit.paymentButtonState
                                      ? null
                                      : () {
                                          Navigator.pushNamed(
                                            context,
                                            Screens.courseDashboardScreen,
                                            arguments: ScreenArguments(
                                              'id',
                                              arguments!.message,
                                            ),
                                          );
                                        },
                                  color: AppColor.roseMadder,
                                  child: Text(
                                    Texts.translate(Texts.studentHomeGoCourseText, context),
                                    textAlign: TextAlign.center,
                                    style: TextStyles
                                        .studentHomeCourseDetailsClickSubscribeStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          )
                        ],
                      ),
                    ),
                  ],
                ));
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
