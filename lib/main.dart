import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/pages/first_setup_page/first_setup_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/initial_page/initial_page.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  void hideSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  hideSystemUI();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });

  WidgetsBinding.instance.addObserver(
    LifecycleEventHandler(resumeCallBack: () async => hideSystemUI()),
  );
}

class MyApp extends StatefulWidget  {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final PreferencesService _preferencesService = PreferencesService();

  Locale _deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  bool _appmonPairing = false;
  bool _isLoading = true;

  Future<Locale> getSavedLocale() async {
    PreferencesService preferencesService = PreferencesService();
    String? languageCode = await preferencesService.getString(AppPreferenceKey.selectLanguage);
    String? countryCode = await preferencesService.getString(AppPreferenceKey.selectCountry);

    if (languageCode != null && countryCode != null) {
      return Locale(languageCode, countryCode);
    }

    return WidgetsBinding.instance.platformDispatcher.locale;
  }

  void _changeLanguage(Locale newLocale) {
    setState(() {
      _deviceLocale = newLocale;
    });
  }

  void _getSetUp() async {
    final String? languageCode = await _preferencesService.getString(AppPreferenceKey.selectLanguage);
    final String? countryCode = await _preferencesService.getString(AppPreferenceKey.selectCountry);
    final String? appmonPairing = await _preferencesService.getString(AppPreferenceKey.appmonPairingName);
    Locale localeSelected = WidgetsBinding.instance.platformDispatcher.locale;

    if (languageCode != null && countryCode != null) {
      localeSelected = Locale(languageCode, countryCode);
    }

    setState(() {
      _deviceLocale = localeSelected;
      _appmonPairing = appmonPairing != null;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSetUp();
    WakelockPlus.enable();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Appli Drive',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
        Locale('ja', 'JP'),
      ],
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (locale != null && locale.languageCode == supportedLocale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      locale: _deviceLocale,
      home: _appmonPairing
        ? InitialPage(onLanguageChange: _changeLanguage)
        : FirstSetupPage(onLanguageChange: _changeLanguage),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final Future<void> Function()? resumeCallBack;

  LifecycleEventHandler({this.resumeCallBack});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && resumeCallBack != null) {
      resumeCallBack!();
    }
  }
}
