import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../../generated/assets.dart';
import '../../../constants/screens.dart';
import '../../../main.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';
import '../../widget/custom_elevation.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  final Color color;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
    required this.color,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final boardController = PageController();

    BoardingModel boarding(context,index) {
      switch (index) {
        case 0:
          return BoardingModel(
            image: Assets.onBoardOnboard1,
            title: Texts.translate(Texts.onBoardTitle1, context),
            body: Texts.translate(Texts.onBoardBody1, context),
            color: AppColor.roseMadder,
          );
        case 1:
          return BoardingModel(
            image: Assets.onBoardOnboard2,
            title: Texts.translate(Texts.onBoardTitle2, context),
            body: Texts.translate(Texts.onBoardBody2, context),
            color: AppColor.indigoDye,
          );
        case 2:
          return BoardingModel(
            image: Assets.onBoardOnboard3,
            title: Texts.translate(Texts.onBoardTitle3, context),
            body: Texts.translate(Texts.onBoardBody3, context),
            color: AppColor.honeyYellow,
          );
        default:
          return BoardingModel(
            image: Assets.onBoardOnboard1,
            title: Texts.translate(Texts.onBoardTitle1, context),
            body: Texts.translate(Texts.onBoardBody1, context),
            color: AppColor.roseMadder,
          );
      }
    }

  bool isLast = false;
  bool isFirst = true;

  void submit(BuildContext context) {
    CacheHelper.saveDataSharedPreference(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Screens.entryScreen,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit(),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    onPageChanged: (int index) {
                      if (index == 0) {
                        isFirst = true;
                        globalCubit.changeLocalState();
                      } else {
                        isFirst = false;
                        globalCubit.changeLocalState();
                      }
                      if (index == 2) {
                        isLast = true;
                        globalCubit.changeLocalState();
                      } else {
                        isLast = false;
                        globalCubit.changeLocalState();
                      }
                    },
                    itemBuilder: (context, index) => buildBoardingItem(
                      boarding(context,index),
                      context,
                    ),
                    itemCount: 3,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model, BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Stack(
            children: [
              Positioned(
                  bottom: 10.0,
                  child: Container(
                    width: 130.0,
                    height: 15.0,
                    color: model.color,
                  )),
              Text(
                Texts.translate(Texts.welcome, context),
                style: TextStyles.welcomeStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        model.title,
                        style: TextStyles.borderingItemTitleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      model.body,
                      style: TextStyles.borderingItemBodyStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: !isFirst
                    ? () {
                        boardController.previousPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    : null,
                icon: Icon(
                   delegate.currentLocale.languageCode == 'ar' ? Icons.check_circle_outlined : Icons.arrow_circle_left_outlined,
                ),
                iconSize: 30.0,
                color: !isFirst ? model.color : AppColor.carosalBG,
              ),
              const SizedBox(
                width: 20.0,
              ),
              SmoothPageIndicator(
                controller: boardController,
                effect: ExpandingDotsEffect(
                  dotColor: model.color.withOpacity(0.3),
                  activeDotColor: model.color,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0,
                ),
                count: 3,
              ),
              const SizedBox(
                width: 20.0,
              ),
              IconButton(
                onPressed: () {
                  if (isLast) {
                    submit(context);
                  } else {
                    boardController.nextPage(
                      duration: const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                icon: Icon(
                  isLast
                      ? Icons.check_circle_outlined
                      : delegate.currentLocale.languageCode == 'ar' ? Icons.arrow_circle_left_outlined : Icons.arrow_circle_right_outlined,
                ),
                iconSize: 30.0,
                color: model.color,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          !isLast
              ? TextButton(
                  onPressed: () {
                    submit(context);
                  },
                  child: Text(
                    Texts.translate(Texts.skip, context),
                    style: TextStyles.skipStyle(model.color),
                  ),
                )
              : const SizedBox(),
          isLast
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomElevation(
                    color: model.color,
                    radius: 21.0,
                    opacity: 0.25,
                    child: MaterialButton(
                      height: MediaQuery.of(context).size.height / 21.05,
                      minWidth: MediaQuery.of(context).size.width / 3,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0)),
                      onPressed: () {
                        submit(context);
                      },
                      color: model.color,
                      child: Text(
                        Texts.translate(Texts.startNow, context),
                        textAlign: TextAlign.center,
                        style: TextStyles.startNowStyle,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );
}
