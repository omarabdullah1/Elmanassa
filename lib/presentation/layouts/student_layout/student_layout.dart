import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../../../business_logic/student_home_cubit/student_home_state.dart';
import '../../styles/colors.dart';

class StudentLayoutScreen extends StatelessWidget {
  const StudentLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentHomeCubit()
      //this will make login for user every time the screen load even in the guest mode.
        ..getCourses()
        ..getBanners()
        ..getLevels()
      ..getMyCourses(),
      child: BlocConsumer<StudentHomeCubit, StudentHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final StudentHomeCubit studentHomeCubit = context.read<StudentHomeCubit>();
          return Scaffold(
            backgroundColor: AppColor.babyBlue,
            body: studentHomeCubit
                .screens[studentHomeCubit.screenIndex],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                studentHomeCubit.changeScreenIndexState(index);
              },
              currentIndex: studentHomeCubit.screenIndex,
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
                // BottomNavigationBarItem(
                //   activeIcon: Icon(
                //     Icons.notification_important_sharp,
                //     color: AppColor.indigoDye,
                //   ),
                //   icon: Icon(
                //     Icons.notification_important_sharp,
                //     color: AppColor.babyBlue,
                //   ),
                //   label: 'Notification',
                // ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person,
                    color: AppColor.indigoDye,
                  ),
                  icon: Icon(
                    Icons.person,
                    color: AppColor.babyBlue,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
