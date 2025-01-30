import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class HintsPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const HintsPage({super.key, required this.onLanguageChange});

  @override
  HintsPagePageState createState() => HintsPagePageState();
}

class HintsPagePageState extends State<HintsPage>{
  void _returnToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
          HomePage(onLanguageChange: widget.onLanguageChange, initSound: false),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-10.0, 0.0);
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
    return Scaffold(
      appBar: _appBarComponent(context),
      body: const Stack(
        children: [
          BackgroundImage(color: "yellow"),
          Center(
            child: Text("Hints page")
          ),
        ],
      ),
    );
  }

  AppBar _appBarComponent(context){
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 246, 124),
              Color.fromARGB(255, 253, 216, 8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          _returnToHomePage(context);
        },
      ),
      centerTitle: true,
      title: Text(
        AppLocalization.of(context).translate("pages.hintsPage.hints"),
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () => (),
          icon: Image.asset(
            'assets/images/icons/light_bulb_box.png',
            height: 50,
            color: Colors.black,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          color: Colors.black,
          height: 2.0,
        ),
      ),
    );
  }
}
