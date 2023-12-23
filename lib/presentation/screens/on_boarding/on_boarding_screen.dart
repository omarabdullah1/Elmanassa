import 'package:edumaster/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
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

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final boardController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard1.png',
      title: 'أول منصة تعليمية ألكترونية بالكامل',
      body:
          'التعليم الجيد و المستمر هو مفتاحك لمستقبل أفضل\n   ..مكان واحد تقدر تتعلم فيه كل المواد و الكورسات    \n                          ابدأ دلوقتي في المنصة ',
      color: AppColor.roseMadder,
    ),
    BoardingModel(
      image: 'assets/images/onboard2.png',
      title: 'أول منصة تعليمية ألكترونية بالكامل',
      body:
          'التعليم الجيد و المستمر هو مفتاحك لمستقبل أفضل\n   ..مكان واحد تقدر تتعلم فيه كل المواد و الكورسات    \n                          ابدأ دلوقتي في المنصة ',
      color: AppColor.indigoDye,
    ),
    BoardingModel(
      image: 'assets/images/onboard3.png',
      title: 'أول منصة تعليمية ألكترونية بالكامل',
      body:
          'التعليم الجيد و المستمر هو مفتاحك لمستقبل أفضل\n   ..مكان واحد تقدر تتعلم فيه كل المواد و الكورسات    \n                          ابدأ دلوقتي في المنصة ',
      color: AppColor.honeyYellow,
    ),
  ];

  bool isLast = false;

  void submit(BuildContext context) {
    CacheHelper.saveDataSharedPreference(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/entry',
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GlobalCubit()..changeLanguageValueWithLang(context, 'en'),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          final GlobalCubit globalCubit = context.read<GlobalCubit>();
          return Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: boardController,
                      onPageChanged: (int index) {
                        if (index == boarding.length - 1) {
                          isLast = true;
                          globalCubit.changeLocalState();
                        } else {
                          isLast = false;
                          globalCubit.changeLocalState();
                        }
                      },
                      itemBuilder: (context, index) => buildBoardingItem(
                        boarding[index],
                        context,
                      ),
                      itemCount: boarding.length,
                    ),
                  ),
                ],
              ),
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
              const Text(
                'مرحبا',
                style: TextStyle(
                  fontFamily: 'cairo',
                  color: AppColor.black,
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      model.title,
                      style: const TextStyle(
                        fontFamily: 'cairo',
                        color: AppColor.indigoDye,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
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
                      style: const TextStyle(
                        fontFamily: 'cairo',
                        color: AppColor.indigoDye,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: FloatingActionButton(
                    heroTag: 'FB${model.color}',
                    onPressed: () {
                      boardController.previousPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                    backgroundColor: model.color,
                    mini: true,
                    elevation: 1,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: model.color.withOpacity(0.3),
                    activeDotColor: model.color,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: FloatingActionButton(
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
                    backgroundColor: model.color,
                    mini: true,
                    elevation: 1,
                    child: Icon(
                      isLast ? Icons.check : Icons.arrow_back_ios_new,
                      size: 18.0,
                    ),
                  ),
                ),
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
                    'تخطي',
                    style: TextStyle(
                      color: model.color,
                      fontSize: 18.0,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ))
              : Padding(
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
                      child: const Text(
                        'أبدا الان',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
}
