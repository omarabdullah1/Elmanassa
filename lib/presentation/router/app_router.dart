import 'package:edumaster/presentation/screens/user/subscription/subscribe_by_code_screen.dart';
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
import '../screens/user/subscription/select_subscription_screen.dart';
import '../screens/user/subscription/subscription_by_id_screen.dart';
import '../screens/user/video_screen/video_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboard':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/entry':
        return MaterialPageRoute(builder: (_) => const EntryScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/student_home':
        return MaterialPageRoute(builder: (_) => const StudentLayoutScreen());
      case '/parent_home':
        return MaterialPageRoute(builder: (_) => const ParentLayoutScreen());
      case '/video':
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => VideoScreen(
            arguments: args,
          ),
        );
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/course_details':
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(
            arguments: args,
          ),
        );
      case '/course_dashboard':
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => CourseDashboardScreen(
            arguments: args,
          ),
        );
      case '/course_subscribe_by_id':
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => SubscriptionScreen(
            arguments: args,
          ),
        );case '/course_subscribe_by_code':
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => SubscriptionByCodeScreen(
            arguments: args,
          ),
        );
      case '/course_subscribe_selection':
        ScreenArguments args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => SubscriptionSelectionScreen(
            arguments: args,
          ),
        );
      default:
        return null;
    }
  }
}
