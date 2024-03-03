import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../generated/assets.dart';
import '../../../constants/screens.dart';
import '../../styles/colors.dart';
import '../../styles/texts.dart';
import '../../widget/custom_elevation.dart';

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
                          Assets.imagesVideoPlay,
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
                            Assets.imagesLogo,
                            height: 80,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              Texts.translate(Texts.entryTitle, context),
                              style: TextStyles.entryTitleStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              Texts.translate(Texts.entryBody1, context),
                              style: TextStyles.entryBody1Style,
                            ),
                          ),
                          Text(
                            Texts.translate(Texts.entryBody2, context),
                            style: TextStyles.entryBody2Style,
                          ),
                          Text(
                            Texts.translate(Texts.entryBody3, context)  ,
                            style: TextStyles.entryBody3Style,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomElevation(
                            color: AppColor.roseMadder,
                            radius: 21.0,
                            opacity: 0.25,
                            child: MaterialButton(
                              height:
                                  MediaQuery.of(context).size.height / 21.05,
                              minWidth: MediaQuery.of(context).size.width / 3,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0)),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Screens.loginScreen,
                                );
                              },
                              color: AppColor.roseMadder,
                              child: Text(
                                Texts.translate(Texts.loginButton, context),
                                textAlign: TextAlign.center,
                                style: TextStyles.loginButtonStyle,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            Texts.translate(Texts.registerHint, context),
                            style: TextStyles.registerHintStyle,
                          ),
                          const SizedBox(
                            height: 1.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Screens.registerScreen,
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  AppColor.roseMadder, // Text Color
                            ),
                            child: Text(
                              Texts.translate(Texts.register, context),
                              style: TextStyles.registerStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 1.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Screens.studentHomeScreen,
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  AppColor.roseMadder, // Text Color
                            ),
                            child: Text(
                              Texts.translate(Texts.skip, context),
                              style: TextStyles.skipStyle(AppColor.roseMadder),
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
