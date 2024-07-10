import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/login_modal.dart';
import 'package:flutter_application_1/features/use_case_1/about.dart';
import 'package:flutter_application_1/features/use_case_3/account_removal.dart';
import 'package:flutter_application_1/features/no_longer_required/department_info.dart';
import 'package:flutter_application_1/features/eservices/eservices.dart';
import 'package:flutter_application_1/features/eservices/services.dart';
import 'package:flutter_application_1/features/use_case_3/favorites.dart';
import 'package:flutter_application_1/features/use_case_3/faq.dart';
import 'package:flutter_application_1/l10n/l10n.dart';
import 'package:flutter_application_1/presentation/home.dart';
import 'package:flutter_application_1/features/no_longer_required/categories.dart';

import 'package:flutter_application_1/features/eservices/health.dart';

import 'package:flutter_application_1/features/use_case_1/forgot_username_otp.dart';
import 'package:flutter_application_1/features/use_case_1/forgotpassword.dart';
import 'package:flutter_application_1/features/use_case_1/forgotusername.dart';
import 'package:flutter_application_1/features/use_case_1/homescreen.dart';
import 'package:flutter_application_1/features/use_case_1/login.dart';
import 'package:flutter_application_1/features/use_case_2/notifications.dart';
import 'package:flutter_application_1/features/use_case_1/otp.dart';
import 'package:flutter_application_1/features/use_case_1/password_update.dart';
import 'package:flutter_application_1/features/use_case_1/profile_update.dart';
import 'package:flutter_application_1/features/use_case_1/register.dart';
import 'package:flutter_application_1/features/use_case_1/registration_detail.dart';
import 'package:flutter_application_1/features/use_case_1/resetpassword.dart';
import 'package:flutter_application_1/features/use_case_2/settings.dart';
import 'package:flutter_application_1/features/use_case_1/about_us_info.dart';
//import 'package:flutter_application_1/features/static/pdf_viewer.dart';
import 'package:flutter_application_1/features/use_case_1/update_username.dart';
import 'package:flutter_application_1/presentation/webpage.dart';
import 'package:flutter_application_1/features/use_case_2/satisfaction_survey.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadFonts();
  //runApp(MainApp());
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: MainApp(),
    ),
  );
}

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

Future<void> loadFonts() async {
  final fontLoader = FontLoader('Gill');
  await fontLoader.load();
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //late Locale _locale;

  // @override
  // void initState() {
  //   super.initState();
  //   _locale = const Locale('en');
  // }

  // void setLocale(Locale newLocale) {
  //   setState(() {
  //     _locale = newLocale;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Colors.green,
                    selectionHandleColor: Colors.green),
                radioTheme: RadioThemeData(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.green)),
                snackBarTheme: SnackBarThemeData(
                    backgroundColor: Colors.orange,
                    contentTextStyle: TextStyle(
                        fontFamily: 'Gill', fontWeight: FontWeight.bold)),
                iconTheme: IconThemeData(color: Colors.green),
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(fontFamily: 'Gill'),
                  bodyMedium: TextStyle(fontFamily: 'Gill'),
                  bodySmall: TextStyle(fontFamily: 'Gill'),
                  labelLarge: TextStyle(fontFamily: 'Gill'),
                  labelMedium: TextStyle(fontFamily: 'Gill'),
                  labelSmall: TextStyle(fontFamily: 'Gill'),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  hoverColor: Colors.green,
                  focusColor: Colors.green,
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                appBarTheme: AppBarTheme(
                    color: Colors.white,
                    titleTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                    iconTheme: IconThemeData(
                      color: hexToColor("#007d4b"),
                    )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: hexToColor("#007d4b"),
                ),
                progressIndicatorTheme:
                    const ProgressIndicatorThemeData(color: Colors.green),
                pageTransitionsTheme: const PageTransitionsTheme(builders: {
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.windows: ZoomPageTransitionsBuilder()
                }),
              ),
              supportedLocales: L10n.all,
              locale: localeProvider.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: '/',
              routes: {
                '/': (context) => const Home(), //home
                '/department_info': (context) => const DepartmentInfo(), //
                '/webpage': (context) => const WebPage(), //
                '/settings': (context) => Settings(), //
                '/notifications': (context) => const Notifications(), //
                '/login': (context) => const Login(), //
                '/register': (context) => const Register(), //
                '/registration_detail': (context) =>
                    const RegistrationDetail(), //
                '/categories': (context) => const Categories(), //
                '/otp': (context) => const Otp(), //
                '/health': (context) => const Health(), //
                'homeScreen': (context) => const HomeScreen(), //
                '/forgotpassword': (context) => const ForgotPasswordScreen(), //
                '/resetpassword': (context) => ResetPasswordScreen(), //
                '/about': (context) => const AboutUs(), //
                '/satisfaction_survey': (context) => SatisfactionSurvey(), //
                '/forgot_username': (context) => ForgotUsername(), //
                '/forgot_username_otp': (context) =>
                    ForgotUsernameOtp(), //forgot_username_otp
                '/update_username': (context) => UpdateUsername(),
                '/update_profile': (context) =>
                    ProfileUpdate(), //update_profile
                '/update_password': (context) => PasswordUpdate(), //
                '/about_us_info': (context) => AboutUsInfo(),
                '/login_modal': (context) => LoginModal(),
                '/account_removal': (context) => AccountRemoval(),
                '/faq': (context) => FAQ(),
                '/eservices': (context) => EServices(), //eservices
                '/services': (context) => Services(),
                '/favorites': (context) => Favorites(), //favorites
                //'/pdf_viewer': (context) => PdfViewer(), //
                //'/': (context) => const CategoriesStatic(),
              },
            ));
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
