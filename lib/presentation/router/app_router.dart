import 'package:edumaster/presentation/screens/user/personal_account/personal_account_screen.dart';
import 'package:edumaster/presentation/screens/user/support/support_screen.dart';
import 'package:flutter/material.dart';
import '../../data/local/args.dart';
import '../layouts/parent_layout/parent_layout_screen.dart';
import '../layouts/student_layout/student_layout.dart';
import '../screens/entry/entry_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/on_boarding/on_boarding_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/shared/splash_screen.dart';
import '../screens/user/course_dashboard/course_dashboard.dart';
import '../screens/user/course_details/course_details.dart';
import '../screens/user/degree/degree_screen.dart';
import '../screens/user/profile/profile_screen.dart';
import '../screens/user/quiz/quiz_screen.dart';
import '../screens/user/quiz_home/quiz_home.dart';
import '../screens/user/subscription/subscription_screen.dart';
import '../screens/user/video_screen/video_screen.dart';
import '../../constants/screens.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Screens.onBoardScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Screens.entryScreen:
        return MaterialPageRoute(builder: (_) => const EntryScreen());
      case Screens.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Screens.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Screens.studentHomeScreen:
        return MaterialPageRoute(builder: (_) => const StudentLayoutScreen());
      case Screens.parentHomeScreen:
        return MaterialPageRoute(builder: (_) => const ParentLayoutScreen());
      case Screens.quizScreen:
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case Screens.quizHomeScreen:
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => QuizHomeScreen(
            arguments: args,
          ),
        );
      case Screens.degreeScreen:
        return MaterialPageRoute(builder: (_) => const DegreesScreen());
        case Screens.supportScreen:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
        case Screens.personalAccountScreen:
        return MaterialPageRoute(builder: (_) => const PersonalAccountScreen());
      case Screens.videoScreen:
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => VideoScreen(
            arguments: args,
          ),
        );
      case Screens.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Screens.courseDetailsScreen:
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(
            arguments: args,
          ),
        );
      case Screens.courseDashboardScreen:
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => CourseDashboardScreen(
            arguments: args,
          ),
        );
      case Screens.courseSubscriptionScreen:
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => SubscriptionScreen(
            arguments: args,
          ),
        );
      default:
        return null;
    }
  }
}
