import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../constants/end_points.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../generated/assets.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/custom_course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentHomeCubit, StudentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StudentHomeCubit studentHomeCubit =
            context.read<StudentHomeCubit>();
        return LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;
            return SafeArea(
              child: RefreshIndicator(
                color: AppColor.indigoDye,
                onRefresh: () async {
                  // print(CacheHelper.sharedPreferences.get('token').toString());
                  // print(CacheHelper.sharedPreferences.get('id').toString());
                  await Future.wait([
                    studentHomeCubit.getCourses(),
                    studentHomeCubit.getBanners(),
                    studentHomeCubit.getMyCourses(),
                    studentHomeCubit.getNotification()
                  ]);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 160.0,
                          decoration: const BoxDecoration(
                            color: AppColor.carosalBG,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: [
                              CarouselSlider(
                                carouselController:
                                    studentHomeCubit.carouselController,
                                items: studentHomeCubit.allBanners!
                                    .map(
                                      (e) => ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.1),
                                          // Adjust the opacity as needed
                                          BlendMode.darken,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: e,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                options: CarouselOptions(
                                  height: 200,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    studentHomeCubit.changeCarosalState(index);
                                    if(index<10){
                                      studentHomeCubit.scrollController.animateTo(
                                        studentHomeCubit.scrollController.position.pixels-80,
                                        duration:
                                        const Duration(milliseconds: 100),
                                        curve: Curves.easeInOut,
                                      );
                                    }else {
                                      studentHomeCubit.scrollController
                                          .animateTo(
                                        studentHomeCubit.scrollController
                                            .position.pixels + 20.0,
                                        duration:
                                        const Duration(milliseconds: 100),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 15.0,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller:
                                        studentHomeCubit.scrollController,
                                    child: DotsIndicator(
                                      dotsCount:
                                          studentHomeCubit.allBanners!.length,
                                      position: studentHomeCubit.currentPage,
                                      decorator: const DotsDecorator(
                                          color: AppColor.carosalBG,
                                          // Inactive color
                                          activeColor: AppColor.white,
                                          spacing: EdgeInsets.all(4.0)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              Texts.translate('studentHomeLevelsText', context),
                              textAlign: TextAlign.center,
                              style: TextStyles.studentHomeLevelsStyle,
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          for (var ele in studentHomeCubit.levelsModel!.levels!)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: GestureDetector(
                                onTap: () async {
                                  await studentHomeCubit.getCoursesByLevel(
                                    studentHomeCubit
                                        .levelsModel!
                                        .levels![studentHomeCubit
                                            .levelsModel!.levels!
                                            .indexOf(ele)]!
                                        .order!,
                                  );
                                },
                                child: SizedBox(
                                  height: 110,
                                  width: 210,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 35,
                                        right: 5,
                                        child: Container(
                                          height: 70.0,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: AppColor.indigoDye,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: AppColor.carosalBG
                                                    .withOpacity(0.4),
                                                blurRadius: 20,
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 150,
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      studentHomeCubit
                                                          .levelsModel!
                                                          .levels![
                                                              studentHomeCubit
                                                                  .levelsModel!
                                                                  .levels!
                                                                  .indexOf(
                                                                      ele)]!
                                                          .title
                                                          .toString(),
                                                      style: TextStyles
                                                          .studentHomeLevelsTextStyle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        height: 116.0,
                                        width: 45.0,
                                        top: 0.0,
                                        right: 0.0,
                                        child: Image.asset(
                                          Assets.iconImgStudent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ]),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: width,
                        constraints: BoxConstraints(
                          minHeight: height * 0.5,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 20.0),
                                  child: Text(
                                    Texts.translate('studentHomeLevelCoursesText', context),
                                    textAlign: TextAlign.center,
                                    style: TextStyles
                                        .studentHomeLevelCoursesTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            state is! GetCoursesLoadingState
                                ? studentHomeCubit
                                        .coursesModel!.courses!.isNotEmpty
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Column(
                                          children: [
                                            for (var i in studentHomeCubit
                                                .coursesModel!.courses!)
                                              CustomMyCourseWidget(
                                                domain: domain,
                                                course: i,
                                                isEnrolled: i!.isEnrolled!,
                                              ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                            Texts
                                                .translate(Texts
                                                .studentHomeNoCoursesForThisLevelText, context),
                                          ),
                                        ],
                                      )
                                : Column(
                                    children: [
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                600 +
                                                120 *
                                                    (studentHomeCubit
                                                        .coursesModel!
                                                        .courses!
                                                        .length),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
