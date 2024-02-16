import 'dart:async';
import 'package:edumaster/generated/assets.dart';
import 'package:edumaster/constants/screens.dart';
import 'package:flutter/material.dart';
import '../../../data/local/cache_helper.dart';
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
        seconds: 3,
      ),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        id == null
            ? Screens.onBoardScreen
            : isParent
                ? Screens.parentHomeScreen
                : Screens.studentHomeScreen,
        (route) => false,
      ),
    );
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesLogo),
            const CircularProgressIndicator(
              color: AppColor.honeyYellow,
            ),
          ],
        ),
      ),
    );
  }
}
