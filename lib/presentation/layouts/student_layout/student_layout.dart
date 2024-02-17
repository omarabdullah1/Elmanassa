import 'package:edumaster/presentation/styles/icons.dart';
import 'package:edumaster/presentation/widget/custom_app_bar.dart';
import 'package:edumaster/presentation/widget/custom_elevation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../constants/screens.dart';
import '../../../data/local/cache_helper.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';

class StudentLayoutScreen extends StatelessWidget {
  const StudentLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()
        //this will make login for user every time the screen load even in the guest mode.
        ..getHomeData(context),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {
          // if(!context.read<StudentHomeCubit>().scaffoldKey.currentState!.isDrawerOpen){
          //   context.read<StudentHomeCubit>().changeDrawerScreenIndexState(0);
          // }
          if (state is LogoutLoadingState) {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.35),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.roseMadder,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColor.black.withOpacity(0.4),
                          blurRadius: 35,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit =
              context.read<StudentHomeCubit>();
          if (CacheHelper.sharedPreferences.getString('token') != null) {
            if (studentHomeCubit.coursesModel != null &&
                studentHomeCubit.bannersModel != null &&
                studentHomeCubit.levelsModel != null &&
                studentHomeCubit.myCoursesModel != null) {
              return Scaffold(
                key: studentHomeCubit.scaffoldKey,
                backgroundColor: AppColor.babyBlue,
                appBar: CustomAppBar(
                    appBarWidget: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Screens.profileScreen,
                        );
                      },
                      child: Image.asset(
                        Assets.iconImgPerson,
                        fit: BoxFit.contain,
                        height: 80.0,
                        width: 80.0,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                    ),
                    Text(
                      studentHomeCubit.screenTitles(
                          context, studentHomeCubit.screenIndex),
                      style: TextStyles.studentHomeHomepageStyle,
                    ),
                  ],
                )),
                body: studentHomeCubit.screens[studentHomeCubit.screenIndex],
                drawer: Align(
                  alignment: delegate.currentLocale.languageCode == 'en'
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: SafeArea(
                    child: Drawer(
                      width: 100.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: delegate.currentLocale.languageCode == 'en'
                              ? const Radius.circular(0)
                              : const Radius.circular(35),
                          bottomLeft:
                              delegate.currentLocale.languageCode == 'en'
                                  ? const Radius.circular(0)
                                  : const Radius.circular(35),
                          topRight: delegate.currentLocale.languageCode == 'en'
                              ? const Radius.circular(35)
                              : const Radius.circular(0),
                          bottomRight:
                              delegate.currentLocale.languageCode == 'en'
                                  ? const Radius.circular(35)
                                  : const Radius.circular(0),
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Screens.profileScreen,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomElevation(
                                  color: AppColor.black,
                                  radius: 20.0,
                                  opacity: 0.2,
                                  child: CircleAvatar(
                                    child: Image.asset(
                                      Assets.iconImgPerson,
                                      fit: BoxFit.contain,
                                      height: 80.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                studentHomeCubit
                                    .changeDrawerScreenIndexState(1);
                                studentHomeCubit.scaffoldKey.currentState!
                                    .closeDrawer();
                                Navigator.pushNamed(
                                  context,
                                  Screens.quizScreen,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.iconImgQuiz,
                                      fit: BoxFit.contain,
                                      height: 36.53,
                                      width: 36.53,
                                    ),
                                    Text(
                                      Texts.translate(
                                          Texts.studentHomeQuizText, context),
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyles.studentHomeIconsTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ), // DrawerHeader
                            InkWell(
                              onTap: () {
                                studentHomeCubit
                                    .changeDrawerScreenIndexState(2);
                                studentHomeCubit.scaffoldKey.currentState!
                                    .closeDrawer();
                                Navigator.pushNamed(
                                  context,
                                  Screens.degreeScreen,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 8.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.iconImgTrueFalse,
                                      fit: BoxFit.contain,
                                      height: 36.53,
                                      width: 36.53,
                                    ),
                                    Text(
                                      Texts.translate(
                                          Texts.studentHomeResultsText,
                                          context),
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyles.studentHomeIconsTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ), // DrawerHeader// DrawerHeader
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 5.0,
                                width: 56.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35.0),
                                  color: AppColor.roseMadder,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: AppColor.black.withOpacity(0.4),
                                      blurRadius: 35,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                studentHomeCubit
                                    .changeDrawerScreenIndexState(3);
                                studentHomeCubit.scaffoldKey.currentState!
                                    .closeDrawer();
                                Navigator.pushNamed(
                                  context,
                                  Screens.supportScreen,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Assets.iconImgHelp,
                                      fit: BoxFit.contain,
                                      height: 36.53,
                                      width: 36.53,
                                    ),
                                    Text(
                                      Texts.translate(
                                          Texts.studentHomeHelpText, context),
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyles.studentHomeIconsTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // DrawerHeader
                            InkWell(
                              onTap: () async {
                                await studentHomeCubit.logOut(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Assets.iconImgLogout,
                                      fit: BoxFit.contain,
                                      height: 36.53,
                                      width: 36.53,
                                    ),
                                    Text(
                                      Texts.translate(
                                          Texts.studentHomeLogoutText, context),
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyles.studentHomeIconsTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ar',
                                  textAlign: TextAlign.center,
                                  style: TextStyles.studentHomeIconsTextStyle,
                                ),
                                CupertinoSwitch(
                                  // This bool value toggles the switch.
                                  value: studentHomeCubit.switchValue,
                                  activeColor: AppColor.indigoDye,
                                  onChanged: (bool? value) {
                                    // This is called when the user toggles the switch.
                                    studentHomeCubit
                                        .changeLanguageValue(context);
                                  },
                                ),
                                Text(
                                  'en',
                                  textAlign: TextAlign.center,
                                  style: TextStyles.studentHomeIconsTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Directionality(
                  textDirection: delegate.currentLocale.languageCode == 'en'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    onTap: (index) {
                      if (index <= 2) {
                        studentHomeCubit.changeScreenIndexState(index);
                      } else {
                        studentHomeCubit.changeDrawerScreenIndexState(0);
                        studentHomeCubit.scaffoldKey.currentState?.openDrawer();
                      }
                    },
                    currentIndex: studentHomeCubit.screenIndex,
                    items: const [
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.home,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.home_outlined,
                          color: AppColor.babyBlue,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.book,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.menu_book_outlined,
                          color: AppColor.babyBlue,
                        ),
                        label: 'My Courses',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.notifications_active,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.notifications_active_outlined,
                          color: AppColor.babyBlue,
                        ),
                        label: 'Notification',
                      ),
                      // BottomNavigationBarItem(
                      //   activeIcon: Icon(
                      //     Icons.person,
                      //     color: AppColor.indigoDye,
                      //   ),
                      //   icon: Icon(
                      //     Icons.person,
                      //     color: AppColor.babyBlue,
                      //   ),
                      //   label: 'Profile',
                      // ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.menu,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.menu,
                          color: AppColor.babyBlue,
                        ),
                        label: 'drag',
                      ),
                    ],
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
          } else {
            if (studentHomeCubit.coursesModel != null &&
                studentHomeCubit.bannersModel != null &&
                studentHomeCubit.levelsModel != null) {
              return Scaffold(
                key: studentHomeCubit.scaffoldKey,
                backgroundColor: AppColor.babyBlue,
                appBar: CustomAppBar(
                    appBarWidget: Row(
                  children: [
                    Image.asset(
                      Assets.iconImgPerson,
                      fit: BoxFit.contain,
                      height: 80.0,
                      width: 80.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                    ),
                    Text(
                      studentHomeCubit.screenTitles(
                          context, studentHomeCubit.screenIndex),
                      style: TextStyles.studentHomeHomepageStyle,
                    ),
                  ],
                )),
                body: studentHomeCubit.screens[studentHomeCubit.screenIndex],
                drawer: Align(
                  alignment: delegate.currentLocale.languageCode == 'en'
                      ? Alignment.centerLeft
                      : Alignment.centerRight,                  child: SafeArea(
                    child: Drawer(
                      width: 100.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: delegate.currentLocale.languageCode == 'en'
                              ? const Radius.circular(0)
                              : const Radius.circular(35),
                          bottomLeft:
                              delegate.currentLocale.languageCode == 'en'
                                  ? const Radius.circular(0)
                                  : const Radius.circular(35),
                          topRight: delegate.currentLocale.languageCode == 'en'
                              ? const Radius.circular(35)
                              : const Radius.circular(0),
                          bottomRight:
                              delegate.currentLocale.languageCode == 'en'
                                  ? const Radius.circular(35)
                                  : const Radius.circular(0),
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                CacheHelper.sharedPreferences.get('token') !=
                                        null
                                    ? Navigator.pushNamed(
                                        context,
                                        Screens.profileScreen,
                                      )
                                    : Navigator.pushNamed(
                                        context,
                                        Screens.entryScreen,
                                      );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomElevation(
                                  color: AppColor.black,
                                  radius: 20.0,
                                  opacity: 0.2,
                                  child: CircleAvatar(
                                    child: Image.asset(
                                      Assets.iconImgPerson,
                                      fit: BoxFit.contain,
                                      height: 80.0,
                                      width: 80.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       Image.asset(
                            //         Assets.iconImgQuiz,
                            //         fit: BoxFit.contain,
                            //         height: 36.53,
                            //         width: 36.53,
                            //       ),
                            //       Text(
                            //         Texts.studentHomeQuizText,
                            //         textAlign: TextAlign.center,
                            //         style: TextStyles.studentHomeIconsTextStyle,
                            //       ),
                            //     ],
                            //   ),
                            // ), // DrawerHeader
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       Image.asset(
                            //         Assets.iconImgTrueFalse,
                            //         fit: BoxFit.contain,
                            //         height: 36.53,
                            //         width: 36.53,
                            //       ),
                            //       Text(
                            //         Texts.studentHomeResultsText,
                            //         textAlign: TextAlign.center,
                            //         style: TextStyles.studentHomeIconsTextStyle,
                            //       ),
                            //     ],
                            //   ),
                            // ), // DrawerHeader
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       Image.asset(
                            //         Assets.iconImgQue,
                            //         fit: BoxFit.contain,
                            //         height: 36.53,
                            //         width: 36.53,
                            //       ),
                            //       Text(
                            //         Texts.studentHomeQueBankText,
                            //         textAlign: TextAlign.center,
                            //         style: TextStyles.studentHomeIconsTextStyle,
                            //       ),
                            //     ],
                            //   ),
                            // ), // DrawerHeader
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                            //     height: 5.0,
                            //     width: 56.0,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(35.0),
                            //       color: AppColor.roseMadder,
                            //       boxShadow: <BoxShadow>[
                            //         BoxShadow(
                            //           color: AppColor.black.withOpacity(0.4),
                            //           blurRadius: 35,
                            //           offset: const Offset(0, 0),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            InkWell(
                              onTap: () {
                                studentHomeCubit.scaffoldKey.currentState!
                                    .closeDrawer();
                                Navigator.pushNamed(
                                  context,
                                  Screens.supportScreen,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Assets.iconImgHelp,
                                      fit: BoxFit.contain,
                                      height: 36.53,
                                      width: 36.53,
                                    ),
                                    Text(
                                      Texts.translate(
                                          Texts.studentHomeHelpText, context),
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyles.studentHomeIconsTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ar',
                                  textAlign: TextAlign.center,
                                  style: TextStyles.studentHomeIconsTextStyle,
                                ),
                                CupertinoSwitch(
                                  // This bool value toggles the switch.
                                  value: studentHomeCubit.switchValue,
                                  activeColor: AppColor.indigoDye,
                                  onChanged: (bool? value) {
                                    // This is called when the user toggles the switch.
                                    studentHomeCubit
                                        .changeLanguageValue(context);
                                  },
                                ),
                                Text(
                                  'en',
                                  textAlign: TextAlign.center,
                                  style: TextStyles.studentHomeIconsTextStyle,
                                ),
                              ],
                            ),
                            // DrawerHeader
                            // InkWell(
                            //   onTap: () async {
                            //     await studentHomeCubit.logOut(context);
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Column(
                            //       children: [
                            //         Image.asset(
                            //           Assets.iconImgLogout,
                            //           fit: BoxFit.contain,
                            //           height: 36.53,
                            //           width: 36.53,
                            //         ),
                            //         Text(
                            //           Texts.studentHomeLogoutText,
                            //           textAlign: TextAlign.center,
                            //           style:
                            //               TextStyles.studentHomeIconsTextStyle,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ), // DrawerHeader
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Directionality(
                  textDirection: delegate.currentLocale.languageCode == 'en'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    onTap: (index) {
                      if (index <= 2) {
                        studentHomeCubit.changeScreenIndexState(index);
                      } else {
                        studentHomeCubit.scaffoldKey.currentState?.openDrawer();
                      }
                    },
                    currentIndex: studentHomeCubit.screenIndex,
                    items: const [
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.home,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.home,
                          color: AppColor.babyBlue,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.menu_book,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.menu_book,
                          color: AppColor.babyBlue,
                        ),
                        label: 'My Courses',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.notification_important_sharp,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.notification_important_sharp,
                          color: AppColor.babyBlue,
                        ),
                        label: 'Notification',
                      ),
                      // BottomNavigationBarItem(
                      //   activeIcon: Icon(
                      //     Icons.person,
                      //     color: AppColor.indigoDye,
                      //   ),
                      //   icon: Icon(
                      //     Icons.person,
                      //     color: AppColor.babyBlue,
                      //   ),
                      //   label: 'Profile',
                      // ),
                      BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.menu,
                          color: AppColor.indigoDye,
                        ),
                        icon: Icon(
                          Icons.menu,
                          color: AppColor.babyBlue,
                        ),
                        label: 'drag',
                      ),
                    ],
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
          }
        },
      ),
    );
  }
}
