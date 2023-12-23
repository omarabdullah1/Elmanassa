import 'package:edumaster/business_logic/parent_home_cubit/parent_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local/cache_helper.dart';
import '../../../main.dart';
import '../../styles/colors.dart';

class ParentLayoutScreen extends StatelessWidget {
  const ParentLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentHomeCubit()
        // ..changeLang(
        //   () => delegate.changeLocale(const Locale('ar')),
        // )
        ..getStudents(),
      child: BlocConsumer<ParentHomeCubit, ParentHomeState>(
        listener: (context, state) async {
          final ParentHomeCubit parentHomeCubit = context.read<ParentHomeCubit>();
          if (state is AppChangeQrState) {
            await Future.wait([
              parentHomeCubit.addStudent(
                  code: parentHomeCubit.qr, context: context),
              parentHomeCubit.getStudents(),
            ]);
            await parentHomeCubit.getStudents();
          }
        },
        builder: (context, state) {
          final ParentHomeCubit parentHomeCubit = context.read<ParentHomeCubit>();
          return Scaffold(
            backgroundColor: AppColor.babyBlue,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                parentHomeCubit.qrCode();
              },
              backgroundColor: AppColor.indigoDye,
              child: const Icon(
                Icons.add,
              ),
            ),
            body: parentHomeCubit
                .screens[parentHomeCubit.screenIndex],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                parentHomeCubit.changeScreenIndexState(index);
              },
              currentIndex: parentHomeCubit.screenIndex,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
