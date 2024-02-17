import 'package:flutter/material.dart';

import '../../business_logic/app_localization.dart';
import '../../main.dart';
import 'colors.dart';

class Texts {
  // static String onBoardTitle1 = 'أول منصة تعليمية إلكترونية بالكامل';
  // static String onBoardTitle2 = 'رحلة تعليمية ممتعة';
  // static String onBoardTitle3 = 'تميز في دراستك';
  // static String onBoardBody1 =
  //     'التعليم الجيد و المستمر هو مفتاحك لمستقبل أفضل \n مكان واحد تقدر تتعلم فيه كل المواد و الكورسات \n ابدأ دلوقتي في المنصة ';
  // static String onBoardBody2 =
  //     'انضم إلى عالمنا واستمتع \n بتجربة تعليمية غنية وسهلة، أينما كنت وفي أي وقت.';
  // static String onBoardBody3 =
  //     'حقق أهدافك التعليمية بمساعدة أدواتنا المتقدمة \n واختباراتنا التي تُقيّم فهمك وتقدمك';
  // static String welcome = 'مرحبا';
  // static String skip = 'تخطي';
  // static String startNow = 'أبدا الان';
  // static String entryTitle = 'أول منصة تعليمية إلكترونية بالكامل';
  // static String entryBody1 = 'التعليم الجيد و المستمر هو مفتاحك لمستقبل أفضل';
  // static String entryBody2 = '..مكان واحد تقدر تتعلم فيه كل المواد و الكورسات';
  // static String entryBody3 = 'ابدأ دلوقتي في المنصة';
  // static String loginButton = 'تسجيل الدخول';
  // static String registerHint = 'ان كنت طالب جديد بالنظام حساب جديد';
  // static String register = 'حساب جديد';
  // static String loginHi = 'أهلا..';
  // static String loginWelcomeForYou = 'مرحبا بك';
  // static String loginEmailLabel = 'الايميل/رقم الهاتف';
  // static String loginPasswordLabel = 'كلمة المرور';
  // static String loginForgetPassword = 'هل نسيت كلمة السر؟';
  // static String continueText = 'أستمرار';
  // static String parentText = 'ولي أمر';
  // static String studentText = 'طالب';
  // static String homeStudentText = 'طالب';
  // static String loginHaveAccountText = 'اذا كان لديك حساب بالفعل';
  // static String registerNewParentText = 'ولي أمر جديد';
  // static String registerFirstNameLabel = 'الإسم الأول';
  // static String registerLastNameLabel = 'الإسم الأخير';
  // static String registerEmailLabel = 'البريد الإلكتروني';
  // static String registerPhoneLabel = 'هاتف';
  // static String registerPasswordLabel = 'كلمة المرور';
  // static String registerConfirmPasswordLabel = 'تأكيد كلمة المرور';
  // static String registerStudentCode = 'كود الطالب';
  // static String registerScanCode = 'مسح الرمز';
  // static String registerPleaseScanCodeText = '*برجاء مسح الرمز';
  // static String registerSelectGenderText = 'اختر النوع';
  // static String registerPleaseSelectGenderText = '*برجاء اختيار النوع';
  // static String registerSelectLevelText = 'اختر المستوي';
  // static String registerPleaseSelectLevelText = '*برجاء اختيار المستوي';
  // static String registerNewStudentText = 'طالب جديد';
  // static String studentHomeHiText = '،أهلا';
  // static String studentHomeGuestText = 'زائر';
  // static String studentHomeHomepageText = 'الرئيسية';
  // static String studentHomeLevelsText = 'المستويات';
  // static String studentHomeMoreButtonText = 'المزيد';
  // static String studentHomeGoCourseText = 'إذهب للكورس';
  // static String studentHomeSubscribeNowText = 'أشترك الان';
  // static String studentHomeSubscribeModelFailMessageText =
  //     'Faild to subscribe course, may be the subscription package exceeded the limit';
  // static String studentHomeRequestFailTitleText = 'فشل الطلب';
  // static String studentHomeRequestSuccessTitleText = 'نجاح الطلب';
  // static String studentHomeCourseDetailsText = 'تفاصيل الدرس';
  // static String studentHomeDetailsText = 'التفاصيل';
  // static String studentHomeVideosText = 'الفيديوهات';
  // static String studentHomeQuizText = 'الاختبارات';
  // static String studentHomeResultsText = 'الدرجات';
  // static String studentHomeQueBankText = 'بنك الاسئلة';
  // static String studentHomeHelpText = 'الدعم';
  // static String studentHomeLogoutText = 'تسجيل الخروج';
  // static String studentHomeLevelCoursesText = 'كورسات المستوى';
  // static String studentHomeNoCoursesForThisLevelText =
  //     'لا توجد كورسات لهذا المستوي';
  // static String studentHomePleaseLoginText = 'من فضلك سجل الدخول';
  // static String studentHomeMyCoursesText = 'كورساتي';
  // static String studentHomeNoCoursesNowPleaseSubscribeText =
  //     'لا توجد كورسات الي الان قم بالاشتراك';
  // static String studentHomeNotificationText = 'الاشعارات';
  // static String studentHomeNotificationReceivedRecentlyText =
  //     'الاشعارات التي وصلت حديثا';
  // static String studentHomeSupportDifferentWaysToConnectText =
  //     'طرق التواصل المختلفة';
  // static String studentHomeSupportSubtitleText =
  //     'يمكنك التواصل معنا من خلال طرق التواصل المختلفة المرفقة بالأسفل طبقا لمواعيد العمل المعلنة.';
  // static String studentHomeThereIsNoNotificationUntillNowText =
  //     'لا توجد اشعارات الي الان';
  // static String studentHomeCourseDetailsCostText = 'السعر';
  // static String studentHomeCourseDetailsDescriptionText = 'وصف المحتوى';
  // static String studentHomeCourseDetailsClickSubscribeText =
  //     'أضغط للاشتراك الان';
  // static String studentHomeCourseDashboardVideoPathText =
  //     'https://www.youtube.com/watch?v=HQ_ytw58tC4';
  // static String studentHomeCourseDashboardCourseDetailsText = 'محتوى الكورس';
  // static String studentHomeCourseDashboardExpandableCardLessonsText = 'دروس ';
  // static String studentHomeCourseDashboardExpandableCardQuesText = 'اختبار';
  // static String studentHomeProfilePageText = 'الصفحة الشخصية';
  // static String studentHomeCourseSubscribeScreenTitleText = 'تفاصيل الاشتراك';
  // static String studentHomeCourseSubscribeScreenEnterPaymentCodeText =
  //     'أدخل كود الدفع';
  // static String studentHomeCourseSubscribeScreenPaymentDetailsText =
  //     'تفاصيل الدفع';
  // static String studentHomeCourseSubscribeScreenTotalCostText = 'المجموع الكلي';
  // static String studentHomeCourseSubscribeScreenPaymentCodeText = 'كود الدفع';
  // static String studentHomeCourseSubscribeScreenPaymentButtonText =
  //     'تأكيد الاشتراك';
  // static String studentHomeCourseSubscribeScreenPaymentConfirmButtonText =
  //     'تأكيد';
  // static String studentHomeQuizConfirmButtonText = 'تأكيد';
  // static String studentHomeQuizNextButtonText = 'التالي';
  // static String studentHomeQuizPreviousButtonText = 'السابق';
  // static String studentHomeMyCoursesNoCoursesEnrolledNowText =
  //     'لا توجد اشتراكات الي الان';
  // static String studentHomeQuizScreenText = 'الاختبارات';
  // static String studentHomeDegreesScreenText = 'النتائج';
  // static String studentHomeSupportScreenText = 'تواصل معنا';
  // static String studentHomeQuizCodeScreenGoToQuizButtonText = 'ابدأ الان';
  // static String studentHomeQuizCodeScreenSendTheQuizButtonText =
  //     'ارسال الامتحان';
  // static String studentHomeQuizCodeScreenSendTheQuizMessageText =
  //     'هل تريد ارسال الامتحان';
  //
  // static String studentHomeQuizThereIsNoDegreesUntilNowText =
  //     'لا توجد نتائج الي الان';
  // static String studentHomeQuizDegreesScreenText = 'الدرجات';

  static String onBoardTitle1 = 'onBoardTitle1';
  static String onBoardTitle2 = 'onBoardTitle2';
  static String onBoardTitle3 = 'onBoardTitle3';
  static String onBoardBody1 = 'onBoardBody1';
  static String onBoardBody2 = 'onBoardBody2';
  static String onBoardBody3 = 'onBoardBody3';
  static String welcome = 'welcome';
  static String skip = 'skip';
  static String startNow = 'startNow';
  static String entryTitle = 'entryTitle';
  static String entryBody1 = 'entryBody1';
  static String entryBody2 = 'entryBody2';
  static String entryBody3 = 'entryBody3';
  static String loginButton = 'loginButton';
  static String registerHint = 'registerHint';
  static String register = 'register';
  static String loginHi = 'loginHi';
  static String loginWelcomeForYou = 'loginWelcomeForYou';
  static String loginEmailLabel = 'loginEmailLabel';
  static String loginPasswordLabel = 'loginPasswordLabel';
  static String loginForgetPassword = 'loginForgetPassword';
  static String continueText = 'continueText';
  static String parentText = 'parentText';
  static String studentText = 'studentText';
  static String homeStudentText = 'homeStudentText';
  static String loginHaveAccountText = 'loginHaveAccountText';
  static String registerNewParentText = 'registerNewParentText';
  static String registerFirstNameLabel = 'registerFirstNameLabel';
  static String registerLastNameLabel = 'registerLastNameLabel';
  static String registerEmailLabel = 'registerEmailLabel';
  static String registerPhoneLabel = 'registerPhoneLabel';
  static String registerPasswordLabel = 'registerPasswordLabel';
  static String registerConfirmPasswordLabel = 'registerConfirmPasswordLabel';
  static String registerStudentCode = 'registerStudentCode';
  static String registerScanCode = 'registerScanCode';
  static String registerPleaseScanCodeText = 'registerPleaseScanCodeText';
  static String registerSelectGenderText = 'registerSelectGenderText';
  static String registerPleaseSelectGenderText = 'registerPleaseSelectGenderText';
  static String registerSelectLevelText = 'registerSelectLevelText';
  static String registerPleaseSelectLevelText = 'registerPleaseSelectLevelText';
  static String registerNewStudentText = 'registerNewStudentText';
  static String studentHomeHiText = 'studentHomeHiText';
  static String studentHomeGuestText = 'studentHomeGuestText';
  static String studentHomeHomepageText = 'studentHomeHomepageText';
  static String studentHomeLevelsText = 'studentHomeLevelsText';
  static String studentHomeMoreButtonText = 'studentHomeMoreButtonText';
  static String studentHomeGoCourseText = 'studentHomeGoCourseText';
  static String studentHomeSubscribeNowText = 'studentHomeSubscribeNowText';
  static String studentHomeSubscribeModelFailMessageText = 'studentHomeSubscribeModelFailMessageText';
  static String studentHomeRequestFailTitleText = 'studentHomeRequestFailTitleText';
  static String studentHomeRequestSuccessTitleText = 'studentHomeRequestSuccessTitleText';
  static String studentHomeCourseDetailsText = 'studentHomeCourseDetailsText';
  static String studentHomeDetailsText = 'studentHomeDetailsText';
  static String studentHomeVideosText = 'studentHomeVideosText';
  static String studentHomeQuizText = 'studentHomeQuizText';
  static String studentHomeResultsText = 'studentHomeResultsText';
  static String studentHomeQueBankText = 'studentHomeQueBankText';
  static String studentHomeHelpText = 'studentHomeHelpText';
  static String studentHomeLogoutText = 'studentHomeLogoutText';
  static String studentHomeLevelCoursesText = 'studentHomeLevelCoursesText';
  static String studentHomeNoCoursesForThisLevelText = 'studentHomeNoCoursesForThisLevelText';
  static String studentHomePleaseLoginText = 'studentHomePleaseLoginText';
  static String studentHomeMyCoursesText = 'studentHomeMyCoursesText';
  static String studentHomeNoCoursesNowPleaseSubscribeText = 'studentHomeNoCoursesNowPleaseSubscribeText';
  static String studentHomeNotificationText = 'studentHomeNotificationText';
  static String studentHomeNotificationReceivedRecentlyText = 'studentHomeNotificationReceivedRecentlyText';
  static String studentHomeSupportDifferentWaysToConnectText = 'studentHomeSupportDifferentWaysToConnectText';
  static String studentHomeSupportSubtitleText = 'studentHomeSupportSubtitleText';
  static String studentHomeThereIsNoNotificationUntillNowText = 'studentHomeThereIsNoNotificationUntillNowText';
  static String studentHomeCourseDetailsCostText = 'studentHomeCourseDetailsCostText';
  static String studentHomeCourseDetailsDescriptionText = 'studentHomeCourseDetailsDescriptionText';
  static String studentHomeCourseDetailsClickSubscribeText = 'studentHomeCourseDetailsClickSubscribeText';
  static String studentHomeCourseDashboardVideoPathText = 'studentHomeCourseDashboardVideoPathText';
  static String studentHomeCourseDashboardCourseDetailsText = 'studentHomeCourseDashboardCourseDetailsText';
  static String studentHomeCourseDashboardExpandableCardLessonsText = 'studentHomeCourseDashboardExpandableCardLessonsText';
  static String studentHomeCourseDashboardExpandableCardQuesText = 'studentHomeCourseDashboardExpandableCardQuesText';
  static String studentHomeProfilePageText = 'studentHomeProfilePageText';
  static String studentHomeCourseSubscribeScreenTitleText = 'studentHomeCourseSubscribeScreenTitleText';
  static String studentHomeCourseSubscribeScreenEnterPaymentCodeText = 'studentHomeCourseSubscribeScreenEnterPaymentCodeText';
  static String studentHomeCourseSubscribeScreenPaymentDetailsText = 'studentHomeCourseSubscribeScreenPaymentDetailsText';
  static String studentHomeCourseSubscribeScreenTotalCostText = 'studentHomeCourseSubscribeScreenTotalCostText';
  static String studentHomeCourseSubscribeScreenPaymentCodeText = 'studentHomeCourseSubscribeScreenPaymentCodeText';
  static String studentHomeCourseSubscribeScreenPaymentButtonText = 'studentHomeCourseSubscribeScreenPaymentButtonText';
  static String studentHomeCourseSubscribeScreenPaymentConfirmButtonText = 'studentHomeCourseSubscribeScreenPaymentConfirmButtonText';
  static String studentHomeQuizConfirmButtonText = 'studentHomeQuizConfirmButtonText';
  static String studentHomeQuizNextButtonText = 'studentHomeQuizNextButtonText';
  static String studentHomeQuizPreviousButtonText = 'studentHomeQuizPreviousButtonText';
  static String studentHomeMyCoursesNoCoursesEnrolledNowText = 'studentHomeMyCoursesNoCoursesEnrolledNowText';
  static String studentHomeQuizScreenText = 'studentHomeQuizScreenText';
  static String studentHomeDegreesScreenText = 'studentHomeDegreesScreenText';
  static String studentHomeSupportScreenText = 'studentHomeSupportScreenText';
  static String studentHomeQuizCodeScreenGoToQuizButtonText = 'studentHomeQuizCodeScreenGoToQuizButtonText';
  static String studentHomeQuizCodeScreenSendTheQuizButtonText = 'studentHomeQuizCodeScreenSendTheQuizButtonText';
  static String studentHomeQuizCodeScreenSendTheQuizMessageText = 'studentHomeQuizCodeScreenSendTheQuizMessageText';
  static String studentHomeQuizThereIsNoDegreesUntilNowText = 'studentHomeQuizThereIsNoDegreesUntilNowText';
  static String studentHomeProfilePersonalAccountText = 'studentHomeProfilePersonalAccountText';
  static String studentHomeProfilePersonalAccountEditTextText = 'studentHomeProfilePersonalAccountEditTextText';
  static String studentHomeProfileQrCodeText = 'studentHomeProfileQrCodeText';
  static String studentHomeProfileQrCodeEditTextText = 'studentHomeProfileQrCodeEditTextText';
  static String studentHomeProfileLogOutText = 'studentHomeProfileLogOutText';
  static String studentHomeProfileLogOutEditTextText = 'studentHomeProfileLogOutEditTextText';
  static String studentHomeProfileMoreText = 'studentHomeProfileMoreText';
  static String studentHomeProfileHelpText = 'studentHomeProfileHelpText';
  static String studentHomeProfileAboutUsText = 'studentHomeProfileAboutUsText';
  static String studentHomeProfileAboutUsDetailsText = 'studentHomeProfileAboutUsDetailsText';
  static String studentHomeProfilePersonalAccountDetailsText = 'studentHomeProfilePersonalAccountDetailsText';
  static String studentHomeQuizPleaseEnterQuizCodeText = 'studentHomeQuizPleaseEnterQuizCodeText';
  // static String studentHomeQuizDegreesScreen = 'studentHomeQuizDegreesScreen';

  static  String translate(String key, context) {
    return delegate.currentLocale.languageCode == 'ar'
        ? AppLocalizations.of(context)!.translate(key) ?? key
        : AppLocalizations.of(context)!.translate(key) ?? key;
  }
}
class TextStyles {
  static TextStyle welcomeStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.black,
    fontSize: 45.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle borderingItemTitleStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle borderingItemBodyStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle skipStyle(color) => TextStyle(
        color: color,
        fontSize: 18.0,
        fontFamily: 'cairo',
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );
  static TextStyle startNowStyle = const TextStyle(
    color: AppColor.white,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle entryTitleStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle entryBody1Style = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle entryBody2Style = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle entryBody3Style = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle loginButtonStyle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle registerHintStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle registerStyle = const TextStyle(
    // fontFamily: 'cairo',
    color: AppColor.roseMadder,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
  static TextStyle loginHiStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 35.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w500,
  );
  static TextStyle loginWelcomeForYouStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 35.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle loginForgetPasswordStyle = const TextStyle(
    // fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
  static TextStyle continueTextStyle = const TextStyle(
    color: AppColor.white,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );

  static TextStyle parentStyle(bool isParent) => TextStyle(
        fontFamily: 'cairo',
        color: isParent ? AppColor.indigoDye : AppColor.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      );

  static TextStyle studentStyle(bool isParent) => TextStyle(
        fontFamily: 'cairo',
        color: !isParent ? AppColor.indigoDye : AppColor.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      );
  static TextStyle loginHaveAccountStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle registerNewParentStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle registerStudentCodeStyle = const TextStyle(
    color: AppColor.babyBlue,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle registerQrCodeStyle = const TextStyle(
    color: AppColor.white,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle registerScanCodeStyle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle registerPleaseScanCodeStyle = const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 14.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w100,
  );
  static TextStyle registerGenderListItemStyle = const TextStyle(
    color: AppColor.babyBlue,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle registerLevelsListItemStyle = const TextStyle(
    color: AppColor.babyBlue,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle registerPleaseSelectGenderStyle = const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 14.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w100,
  );
  static TextStyle registerPleaseSelectLevelStyle = const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 14.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w100,
  );
  static TextStyle registerNewStudentStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle registerSelectLevelStyle = const TextStyle(
    color: AppColor.babyBlue,
    fontSize: 18,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeHiStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 18.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeFirstLastNameStyle = const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 20.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeGuestStyle = const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 20.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeStudentStyle = const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 14.0,
    fontFamily: 'cairo',
    // fontWeight: FontWeight.w500,
  );
  static TextStyle studentHomeHomepageStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeLevelsStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeMoreButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeGoSubscribeCourseButtonTextStyle =
      const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeCourseDetailsTextStyle = const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.indigoDye,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle studentHomeDetailsTextStyle(bool isVideos) => TextStyle(
        fontFamily: 'cairo',
        color: isVideos ? AppColor.honeyYellow : AppColor.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      );

  static TextStyle studentHomeVideosTextStyle(bool isVideos) => TextStyle(
        fontFamily: 'cairo',
        color: !isVideos ? AppColor.honeyYellow : AppColor.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      );
  static TextStyle studentHomeIconsTextStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'cairo',
    // fontWeight: FontWeight.w500,
  );
  static TextStyle studentHomeLevelsTextStyle = const TextStyle(
    color: AppColor.honeyYellow,
    fontSize: 18.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeLevelCoursesTextStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeMyCoursesTextStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeLogoutTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );

  static TextStyle studentHomeCourseDetailsTagsStyle(int index) => TextStyle(
        color: AppColor.tagsColors[index],
        fontSize: 18,
        fontFamily: 'cairo',
        fontWeight: FontWeight.bold,
      );
  static TextStyle studentHomeCourseDetailsTitleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeCourseDetailsDescriptionValueStyle =
      const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 14,
    // fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseDetailsClickSubscribeStyle =
      const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeCourseDashboardCourseTitleStyle = const TextStyle(
    color: AppColor.black,
    fontSize: 20,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseDashboardCourseLessonTitleStyle =
      const TextStyle(
    color: AppColor.roseMadder,
    // fontSize: 22,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseDashboardCourseDetailsTextStyle =
      const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 20,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseDashboardExpandableCardLessonsTextStyle =
      const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 16,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseDashboardExpandableCardQuesTextStyle =
      const TextStyle(
    color: AppColor.roseMadder,
    // fontSize: 22,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle
      studentHomeCourseDashboardExpandableCardVideoDurationTextStyle =
      const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 18.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseSubscriptionCourseTitleStyle =
      const TextStyle(
    color: AppColor.white,
    fontSize: 22.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseSubscriptionEnterPaymentCodeStyle =
      const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseSubscribeScreenPaymentDetailsTextStyle =
      const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseSubscribeScreenTotlaCostTextStyle =
      const TextStyle(
    color: AppColor.black,
    fontSize: 18.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w300,
  );
  static TextStyle studentHomeCourseSubscribeScreenTotlaCostValueStyle =
      const TextStyle(
    color: AppColor.black,
    fontSize: 18.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeCourseSubscribeScreenPaymentCodeTextInputStyle =
      const TextStyle(
    fontFamily: 'cairo',
    color: AppColor.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle studentHomeCourseDetailsClickSubscribeCheckStyle =
      const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'cairo',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeNotificationTitleStyle = const TextStyle(
    fontFamily: "Tajawal",
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );
  static TextStyle studentHomeNotificationDescriptionStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.royalBlue,
  );
  static TextStyle studentHomeNotificationDateTimeStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColor.grey,
  );
  static TextStyle studentHomeMyCoursesNoCoursesStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.royalBlue,
  );
  static TextStyle studentHomeNotificationReceivedRecentlyTextStyle =
      const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeDifferentWaysToConnectTextStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 22.0,
    fontFamily: 'cairo',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeSupportSubtitleTextStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColor.grey,
  );
  static TextStyle studentHomeProfileNameTextStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.white,
  );
  static TextStyle studentHomeProfileTypeTextStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.indigoDye,
  );
  static TextStyle studentHomeProfilePersonalAccountTextStyle = const TextStyle(
    fontFamily: "Tajawal",
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
  );
  static TextStyle studentHomeProfilePersonalAccountEditTextStyle = TextStyle(
    fontFamily: "Cairo",
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColor.grey.withOpacity(0.6),
  );
  static TextStyle studentHomeQuizScreenTitleTextStyle = const TextStyle(
    color: AppColor.roseMadder,
    fontSize: 22.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.bold,
  );
  static TextStyle studentHomeQuizScreenQuesTitleTextStyle = const TextStyle(
    color: AppColor.indigoDye,
    fontSize: 18.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeQuizScreenQuesDetailsTextStyle = const TextStyle(
    color: AppColor.black,
    fontSize: 18.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeQuizConfirmButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 17.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeQuizPreviousButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 17.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w700,
  );
  static TextStyle studentHomeQuizTypeTextStyle = const TextStyle(
    fontFamily: "Tajawal",
    fontSize: 10.8,
    fontWeight: FontWeight.w600,
    color: AppColor.indigoDye,
  );
  static TextStyle studentHomeQuizDegreeDescriptionTextStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.royalBlue,
  );
  static TextStyle studentHomeQuizDegreeDateTimeStyle = const TextStyle(
    fontFamily: "Cairo",
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColor.grey,
  );
  static TextStyle studentHomeQuizDegreeSuccessFailBoxTextStyle (Color color)=>  TextStyle(
    color: color,
    fontSize: 17.0,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w700,
  );
}
