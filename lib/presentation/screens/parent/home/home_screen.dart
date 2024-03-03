import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/parent_home_cubit/parent_home_cubit.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../styles/colors.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParentHomeCubit, ParentHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final ParentHomeCubit parentHomeCubit = context.read<ParentHomeCubit>();
        return CacheHelper.getDataFromSharedPreference(key: 'token')!=null &&
                parentHomeCubit.parentGetStudentsModel != null
            ? Builder(
                builder: (context) => SafeArea(
                  child: RefreshIndicator(
                    color: AppColor.indigoDye,
                    onRefresh: () async {
                      // Future.delayed(Duration(seconds: 2));
                      await parentHomeCubit.getStudents();
                      // await Future.wait(
                      // [bloc.getCourses(), bloc.getBanners()]);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    24.0,
                                  ),
                                  color: AppColor.cardGray,
                                ),
                                height: 120.0,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${parentHomeCubit.parentGetStudentsModel!.parentStudents![index]!.firstName!} ',
                                              ),
                                              Text(
                                                parentHomeCubit
                                                    .parentGetStudentsModel!
                                                    .parentStudents![index]!
                                                    .lastName!,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Code: ',
                                              ),
                                              Text(
                                                parentHomeCubit
                                                    .parentGetStudentsModel!
                                                    .parentStudents![index]!
                                                    .code!,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: AppColor.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: BarcodeWidget(
                                              data: parentHomeCubit
                                                  .parentGetStudentsModel!
                                                  .parentStudents![index]!
                                                  .code!,
                                              barcode: Barcode.qrCode(),
                                              color: Colors.black,
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10.0),
                            itemCount: parentHomeCubit
                                .parentGetStudentsModel!.parentStudents!.length,
                          ),
                        )
                      ],
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
