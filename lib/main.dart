import 'dart:async';

import 'package:edumaster/presentation/router/app_router.dart';
import 'package:edumaster/presentation/styles/colors.dart';
import 'package:edumaster/presentation/widget/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'business_logic/app_localization.dart';
import 'business_logic/bloc_observer.dart';
import 'business_logic/global_cubit/global_cubit.dart';
import 'data/local/cache_helper.dart';
import 'data/remote/dio_helper.dart';

late LocalizationDelegate delegate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await CacheHelper.sharedPreferences.clear();
  DioHelper.init();
  await CacheHelper.init();
  final locale =
      CacheHelper.getDataFromSharedPreference(key: 'language') ?? "ar";
  delegate = await LocalizationDelegate.create(
    fallbackLocale: locale,
    supportedLocales: ['ar', 'en'],
  );
  await delegate.changeLocale(Locale(locale));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({
    required this.appRouter,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = delegate.currentLocale.languageCode;

    delegate.onLocaleChanged = (Locale value) async {
      try {
        setState(() {
          Intl.defaultLocale = value.languageCode;
        });
      } catch (e) {
        showToast(e.toString());
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit(),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LocalizedApp(
                delegate,
                LayoutBuilder(builder: (context, constraints) {
                  return MaterialApp(
                    // debugShowCheckedModeBanner: false,
                    title: 'Droosak Online',
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      delegate,
                    ],
                    locale: delegate.currentLocale,

                    supportedLocales: delegate.supportedLocales,
                    onGenerateRoute: widget.appRouter.onGenerateRoute,
                    theme: ThemeData(
                      fontFamily: 'cairo',
                      progressIndicatorTheme: const ProgressIndicatorThemeData(
                          color: AppColor.babyBlue),
                      primarySwatch: AppColor.defaultColor,
                      textSelectionTheme: const TextSelectionThemeData(
                        selectionHandleColor: AppColor.babyBlue,
                        cursorColor: AppColor.babyBlue,
                        selectionColor: AppColor.babyBlue,
                      ),
                      radioTheme: RadioThemeData(fillColor: MaterialStateColor.resolveWith(
                        (states) => AppColor.indigoDye,
                      )),
                      // splashColor: AppColor.indigoDye,
                      //scaffoldBackgroundColor: AppColors.white,
                      appBarTheme: const AppBarTheme(
                        elevation: 0.0,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: AppColor.transparent,
                          statusBarIconBrightness: Brightness.dark,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}
