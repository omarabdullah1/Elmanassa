import 'dart:async';
import 'package:flutter/material.dart';
import '../../../data/local/cache_helper.dart';
import '../../../generated/assets.dart';
import '../../styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var id = CacheHelper.getDataFromSharedPreference(key: 'id');
    var isParent = CacheHelper.getDataFromSharedPreference(key: 'isParent');
    timer = Timer(
        const Duration(
          seconds: 1,
        ),
        () => Navigator.pushNamedAndRemoveUntil(
            context,
            id == null
                ? '/onboard'
                : isParent
                    ? '/parent_home'
                    : '/student_home',
            (route) => false));
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Image.asset(Assets.imagesLogo02),
      ),
    );
  }
}
