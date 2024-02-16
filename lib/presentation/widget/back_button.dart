import 'package:flutter/material.dart';

import '../styles/colors.dart';

class BackButtonWidget extends StatelessWidget {
  final double? height;

  const BackButtonWidget({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: height ?? 40.0,
          width: height ?? 40.0,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(25.0),
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     color: AppColor.black.withOpacity(0.4),
            //     blurRadius: 35,
            //     offset: const Offset(0, 0),
            //   ),
            // ],
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20.0,
              color: AppColor.roseMadder,
            ),
          ),
        ),
      ),
    );
  }
}
