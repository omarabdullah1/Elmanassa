import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/parent_home_cubit/parent_home_cubit.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../widget/custom_elevation.dart';


class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParentHomeCubit, ParentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        // final ParentHomeCubit parentHomeCubit = context.read<ParentHomeCubit>();
        return CacheHelper.getDataFromSharedPreference(key: 'token')!=null
            ? Scaffold(
                backgroundColor: AppColor.babyBlue,
                body: Builder(
                  builder: (context) => SafeArea(
                    child: RefreshIndicator(
                      color: AppColor.indigoDye,
                      onRefresh: () async {
                        // await Future.wait(
                        // [bloc.getCourses(), bloc.getBanners()]);
                      },
                      child: CacheHelper.getDataFromSharedPreference(key: 'token')==null
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
                                          Screens.entryScreen,
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
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Center(child: Text('Profile Screen')),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     borderRadius:
                                  //         BorderRadius.circular(20.0),
                                  //     color: AppColor.white,
                                  //   ),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(15.0),
                                  //     child: BarcodeWidget(
                                  //       data: bloc.parentModel!.user!.code!,
                                  //       barcode: Barcode.qrCode(),
                                  //       color: Colors.black,
                                  //       width: 200,
                                  //       height: 200,
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 20.0,
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
                                          Screens.entryScreen,
                                        );
                                      },
                                      color: AppColor.roseMadder,
                                      child: const Text(
                                        'تسجيل الخروج',
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
