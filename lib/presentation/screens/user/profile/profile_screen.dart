import 'package:barcode_widget/barcode_widget.dart';
import 'package:edumaster/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../constants/screens.dart';
import '../../../../generated/assets.dart';
import '../../../styles/colors.dart';
import '../../../styles/texts.dart';
import '../../../widget/back_button.dart';
import '../../../widget/custom_elevation.dart';
import '../../../widget/flat_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()..getProfile(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {
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
          if (studentHomeCubit.profileModel != null) {
            return Scaffold(
              backgroundColor: AppColor.babyBlue,
              appBar: CustomAppBar(
                  appBarWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 40.0,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      Texts.translate(
                          Texts.studentHomeProfilePageText, context),
                      style: TextStyles.studentHomeHomepageStyle,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  const BackButtonWidget(),
                ],
              )),
              body: LayoutBuilder(builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 18.0),
                        child: Container(
                          height: 90.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.roseMadder,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.indigoDye500,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppColor.black.withOpacity(0.4),
                                blurRadius: 35,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // textBaseline: TextBaseline.ideographic,
                              children: [
                                CircleAvatar(
                                  child: Image.asset(
                                    Assets.iconImgPerson,
                                    fit: BoxFit.cover,
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: SizedBox(
                                    height: height * 0.07,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${studentHomeCubit.profileModel!.profile!.firstName!} ${studentHomeCubit.profileModel!.profile!.lastName!}',
                                          style: TextStyles
                                              .studentHomeProfileNameTextStyle,
                                        ),
                                        Text(
                                          studentHomeCubit.profileModel!
                                                      .profile!.role ==
                                                  'student'
                                              ? Texts.translate(
                                                  Texts.studentText, context)
                                              : Texts.translate(
                                                  Texts.parentText, context),
                                          style: TextStyles
                                              .studentHomeProfileTypeTextStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height - 126.0,
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Screens.personalAccountScreen,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24.0,
                                      bottom: 9.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColor.roseMadder
                                              .withOpacity(0.1),
                                          child: const Icon(
                                            Icons.person_outline_outlined,
                                            color: AppColor.roseMadder,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfilePersonalAccountText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountTextStyle,
                                              ),
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfilePersonalAccountEditTextText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountEditTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              Screens.personalAccountScreen,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                AppColor.grey.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Container(
                                          height: height * 0.4,
                                          width: width * 0.5,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColor.roseMadder,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColor.white,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: AppColor.black
                                                    .withOpacity(0.4),
                                                blurRadius: 35,
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppColor
                                                    .roseMadder
                                                    .withOpacity(0.1),
                                                child: const Icon(
                                                  Icons.qr_code_outlined,
                                                  color: AppColor.roseMadder,
                                                ),
                                              ),
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfileQrCodeText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountTextStyle,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: BarcodeWidget(
                                                  data: studentHomeCubit
                                                      .profileModel!
                                                      .profile!
                                                      .code!,
                                                  barcode: Barcode.qrCode(),
                                                  color: AppColor.indigoDye,
                                                  width: 200,
                                                  height: 200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 9.0,
                                      bottom: 9.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColor.roseMadder
                                              .withOpacity(0.1),
                                          child: const Icon(
                                            Icons.qr_code_outlined,
                                            color: AppColor.roseMadder,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfileQrCodeText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountTextStyle,
                                              ),
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfileQrCodeEditTextText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountEditTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Container(
                                                  height: height * 0.4,
                                                  width: width * 0.5,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          AppColor.roseMadder,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColor.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        blurRadius: 35,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            AppColor.roseMadder
                                                                .withOpacity(
                                                                    0.1),
                                                        child: const Icon(
                                                          Icons
                                                              .qr_code_outlined,
                                                          color: AppColor
                                                              .roseMadder,
                                                        ),
                                                      ),
                                                      Text(
                                                        Texts.translate(
                                                            Texts
                                                                .studentHomeProfileQrCodeText,
                                                            context),
                                                        style: TextStyles
                                                            .studentHomeProfilePersonalAccountTextStyle,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: BarcodeWidget(
                                                          data: studentHomeCubit
                                                              .profileModel!
                                                              .profile!
                                                              .code!,
                                                          barcode:
                                                              Barcode.qrCode(),
                                                          color: AppColor
                                                              .indigoDye,
                                                          width: 200,
                                                          height: 200,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                AppColor.grey.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    studentHomeCubit.logOut(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 9.0,
                                      bottom: 9.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColor.roseMadder
                                              .withOpacity(0.1),
                                          child: const Icon(
                                            Icons.logout_outlined,
                                            color: AppColor.roseMadder,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfileLogOutText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountTextStyle,
                                              ),
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfileLogOutEditTextText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountEditTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            studentHomeCubit.logOut(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                AppColor.grey.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 9.0,
                                    bottom: 9.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        Texts.translate(
                                            Texts.studentHomeProfileMoreText,
                                            context),
                                        style: TextStyles
                                            .studentHomeProfilePersonalAccountTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Screens.supportScreen,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 9.0,
                                      bottom: 9.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColor.roseMadder
                                              .withOpacity(0.1),
                                          child: const Icon(
                                            Icons.help_outline_outlined,
                                            color: AppColor.roseMadder,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                            Texts.translate(
                                                Texts
                                                    .studentHomeProfileHelpText,
                                                context),
                                            style: TextStyles
                                                .studentHomeProfilePersonalAccountTextStyle,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              Screens.supportScreen,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                AppColor.grey.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Container(
                                          height: height * 0.2,
                                          width: width * 0.9,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColor.roseMadder,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColor.white,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: AppColor.black
                                                    .withOpacity(0.4),
                                                blurRadius: 35,
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppColor
                                                    .roseMadder
                                                    .withOpacity(0.1),
                                                child: const FaIcon(
                                                  FontAwesomeIcons.heart,
                                                  color: AppColor.roseMadder,
                                                ),
                                              ),
                                              Text(
                                                Texts.translate(
                                                    Texts
                                                        .studentHomeProfileAboutUsText,
                                                    context),
                                                style: TextStyles
                                                    .studentHomeProfilePersonalAccountTextStyle,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  15.0,
                                                ),
                                                child: Text(
                                                  Texts.translate(
                                                      Texts
                                                          .studentHomeProfileAboutUsDetailsText,
                                                      context),
                                                  style: TextStyles
                                                      .studentHomeProfilePersonalAccountTextStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 9.0,
                                      bottom: 9.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColor.roseMadder
                                              .withOpacity(0.1),
                                          child: const FaIcon(
                                            FontAwesomeIcons.heart,
                                            color: AppColor.roseMadder,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                            Texts.translate(
                                                Texts
                                                    .studentHomeProfileAboutUsText,
                                                context),
                                            style: TextStyles
                                                .studentHomeProfilePersonalAccountTextStyle,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Container(
                                                  height: height * 0.2,
                                                  width: width * 0.9,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          AppColor.roseMadder,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColor.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        blurRadius: 35,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            AppColor.roseMadder
                                                                .withOpacity(
                                                                    0.1),
                                                        child: const FaIcon(
                                                          FontAwesomeIcons
                                                              .heart,
                                                          color: AppColor
                                                              .roseMadder,
                                                        ),
                                                      ),
                                                      Text(
                                                        Texts.translate(
                                                            Texts
                                                                .studentHomeProfileAboutUsText,
                                                            context),
                                                        style: TextStyles
                                                            .studentHomeProfilePersonalAccountTextStyle,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(
                                                          15.0,
                                                        ),
                                                        child: Text(
                                                          Texts.translate(
                                                              Texts
                                                                  .studentHomeProfileAboutUsDetailsText,
                                                              context),
                                                          style: TextStyles
                                                              .studentHomeProfilePersonalAccountTextStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                AppColor.grey.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
