import 'package:edumaster/presentation/styles/colors.dart';
import 'package:edumaster/presentation/widget/custom_elevation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.babyBlue,
          body: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 45.0,
                    ),
                    const Expanded(
                      child: Image(
                        image: AssetImage(
                          'assets/images/videoPlay.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 3,
                            color: Colors.black12,
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      // height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 80,
                          ),
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'أول منصة تعليمية ألكترونية بالكامل',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                color: AppColor.indigoDye,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'التعليم الجيد و المستمر هو مفتاحك لمستقبل أفضل',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                color: AppColor.indigoDye,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Text(
                            '..مكان واحد تقدر تتعلم فيه كل المواد و الكورسات',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              color: AppColor.indigoDye,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'ابدأ دلوقتي في المنصة',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              color: AppColor.indigoDye,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomElevation(
                            color: AppColor.roseMadder,
                            radius: 21.0,
                            opacity: 0.25,
                            child: MaterialButton(
                              height: MediaQuery.of(context).size.height / 21.05,
                              minWidth: MediaQuery.of(context).size.width / 3,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0)),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/login',
                                );
                              },
                              color: AppColor.roseMadder,
                              child: const Text(
                                'تسجيل الدخول',
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'ان كنت طالب جديد بالنظام حساب جديد',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              color: AppColor.indigoDye,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 1.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/register',
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColor.roseMadder, // Text Color
                            ),
                            child: const Text(
                              'حساب جديد',
                              style: TextStyle(
                                // fontFamily: 'cairo',
                                color: AppColor.roseMadder,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),const SizedBox(
                            height: 1.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/student_home',
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColor.roseMadder, // Text Color
                            ),
                            child: const Text(
                              'تخطي',
                              style: TextStyle(
                                // fontFamily: 'cairo',
                                color: AppColor.roseMadder,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
