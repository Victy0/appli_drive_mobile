import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/pages/first_setup_page/first_setup_page.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/initial_page/initial_page.dart';
import 'package:appli_drive_mobile/services/audio_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:screen_state/screen_state.dart';
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
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(resumeCallBack: () async => hideSystemUI()),
    );
  });
}

class MyApp extends StatefulWidget  {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final PreferencesService _preferencesService = PreferencesService();
  final AudioService _audioService = AudioService();
  final Screen _screen = Screen();

  Stream<ScreenStateEvent>? _screenStream;
  Locale _deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  bool _appmonPairing = false;
  bool _isLoading = true;

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

  void _startMonitoring() {
    _screenStream = _screen.screenStateStream;
    _screenStream?.listen((event) {
      if (event == ScreenStateEvent.SCREEN_OFF) {
        _audioService.pauseBackground();
      } else if (event == ScreenStateEvent.SCREEN_UNLOCKED) {
        _audioService.resumeBackground();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getSetUp();
    _audioService.preloadAudiosEffects({
      "start": "sounds/start.mp3",
      "continue_fs": "sounds/continue_first_step.mp3",
      "click": "sounds/click.mp3",
      "back": "sounds/back.mp3",
      "appliarise": "sounds/appliarise_init.mp3",
      "error": "sounds/error.mp3",
      "": "sounds/back.mp3",
    });
    _startMonitoring();
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
        return supportedLocales.firstWhere(
          (supportedLocale) => locale?.languageCode == supportedLocale.languageCode,
          orElse: () => supportedLocales.first,
        );
      },
      locale: _deviceLocale,
      home: MainAppPage(
        locale: _deviceLocale,
        appmonPairing: _appmonPairing,
        onLanguageChange: _changeLanguage,
      ),
    );
  }
}

class MainAppPage extends StatelessWidget {
  final Locale locale;
  final bool appmonPairing;
  final void Function(Locale) onLanguageChange;

  const MainAppPage({
    super.key,
    required this.locale,
    required this.appmonPairing,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return appmonPairing
      ? InitialPage(onLanguageChange: onLanguageChange)
      : FirstSetupPage(onLanguageChange: onLanguageChange);
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
