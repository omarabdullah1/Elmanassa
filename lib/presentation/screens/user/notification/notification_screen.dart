import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../styles/colors.dart';
import '../../../widget/custom_elevation.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentHomeCubit, StudentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final StudentHomeCubit studentHomeCubit = context.read<StudentHomeCubit>();
        return studentHomeCubit.coursesModel != null &&
                studentHomeCubit.bannersModel != null
            ? Scaffold(
                backgroundColor: AppColor.babyBlue,
                body: Localizations.override(
                  context: context,
                  locale: const Locale('en'),
                  child: Builder(
                    builder: (context) => SafeArea(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // await Future.wait(
                          // [studentHomeCubit.getCourses(), studentHomeCubit.getBanners()]);
                        },
                        child: CacheHelper.sharedPreferences.getString('token') == null
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Center(
                                        child: Text('من فضلك سجل الدخول')),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    CustomElevation(
                                      color: AppColor.roseMadder,
                                      radius: 21.0,
                                      opacity: 0.25,
                                      child: MaterialButton(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(21.0)),
                                        onPressed: () {
                                          CacheHelper.sharedPreferences.clear();
                                          Navigator.pushNamed(
                                            context,
                                            '/entry',
                                          );
                                        },
                                        color: AppColor.roseMadder,
                                        child: const Text(
                                          'تسجيل الدخول',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'cairo',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SingleChildScrollView(
                                child:
                                    Center(child: Text('Notification Screen')),
                              ),
                      ),
                    ),
                  ),
                ),
              )
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
