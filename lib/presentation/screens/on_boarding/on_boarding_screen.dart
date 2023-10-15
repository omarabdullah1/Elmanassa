import 'package:edumaster/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';

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
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
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

  void submit() {
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
  void initState() {
    GlobalCubit.get(context).changeLanguageValueWithLang(context,'en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
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
                  fontFamily: 'tajawal',
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
          Text(
            model.title,
            style: const TextStyle(
              fontFamily: 'tajawal',
              color: AppColor.indigoDye,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontFamily: 'tajawal',
              color: AppColor.indigoDye,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.0,
                width: 30.0,
                child: FloatingActionButton(
                  onPressed: () {
                    boardController.previousPage(
                      duration: const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18.0,
                  ),
                  backgroundColor: model.color,
                  mini: true,
                  elevation: 1,
                ),
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
                count: boarding.length,
              ),
              const SizedBox(
                width: 20.0,
              ),
              SizedBox(
                height: 30.0,
                width: 30.0,
                child: FloatingActionButton(
                  heroTag: 'FB' + model.color.toString(),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18.0,
                  ),
                  backgroundColor: model.color,
                  mini: true,
                  elevation: 1,
                ),
              ),
            ],
          ),
        ],
      );
}
