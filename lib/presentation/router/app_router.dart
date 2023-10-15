import 'package:flutter/material.dart';
import '../screens/entry/entry_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/on_boarding/on_boarding_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/shared/splash_screen.dart';
import '../screens/user/user_profile.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/onboard':
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case '/entry':
        return MaterialPageRoute(builder: (_) =>  const EntryScreen());
        case '/login':
        return MaterialPageRoute(builder: (_) =>  const LoginScreen());
        case '/profile':
        return MaterialPageRoute(builder: (_) =>  const UserProfileScreen());
        case '/register':
        return MaterialPageRoute(builder: (_) =>  const RegisterScreen());
      default:
        return null;
    }
  }
}