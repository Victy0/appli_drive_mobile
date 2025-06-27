import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/components/custom_app_bar.dart';
import 'package:appli_drive_mobile/interfaces/pages/hints_page/components/grouped_card_list.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class HintsPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const HintsPage({super.key, required this.onLanguageChange});

  @override
  HintsPagePageState createState() => HintsPagePageState();
}

class HintsPagePageState extends State<HintsPage> {
  final PreferencesService _preferencesService = PreferencesService();
  
  List<Map<String, dynamic>> _hintList = [];
  bool _isLoading = true;

  void _getHintList() async {
    List<Map<String, dynamic>> result = await _preferencesService.getHintRevealedList();

    setState(() {
      _hintList = result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getHintList();
  }
  
  void _returnToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
          HomePage(onLanguageChange: widget.onLanguageChange, initSound: false),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: CustomAppBar(
        titleText: AppLocalization.of(context).translate("pages.hintsPage.hints"),
        image: "assets/images/icons/light_bulb_box.png",
        backgroundColor: const [
          Color.fromARGB(255, 255, 246, 124),
          Color.fromARGB(255, 253, 216, 8),
        ],
        textBlack: true,
      ),
      body: Stack(
        children: [
          const BackgroundImage(color: "yellow", animateColor: true),
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GroupedCardList(
                        hintList: _hintList,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          ClosePageButton(onLanguageChange: widget.onLanguageChange, onTap: _returnToHomePage),
        ],
      ),
    );
  }
}
