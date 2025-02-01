import 'package:appli_drive_mobile/interfaces/pages/data_center_page/data_center_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/hints_page/hints_page.dart';
import 'package:appli_drive_mobile/interfaces/pages/seven_code_page/seven_code_page.dart';
import 'package:flutter/material.dart';

class MenuIcons extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const MenuIcons({super.key, required this.onLanguageChange});

  @override
  MenuIconsState createState() => MenuIconsState();
}

class MenuIconsState extends State<MenuIcons> {  
  void _navigateToDataCenterPage(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => 
          DataCenterPage(onLanguageChange: widget.onLanguageChange),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToSevenCodePage(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => 
          SevenCodePage(onLanguageChange: widget.onLanguageChange),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToHintsPage(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => 
          HintsPage(onLanguageChange: widget.onLanguageChange),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

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
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 16, bottom: 16, left: 16),
      child: Row(
        children: [
          const Spacer(),
          iconDataCenter(context),
          iconSevenCode(context),
          iconHints(context),
          const Spacer(),
        ],
      ),
    );
  }

  Widget iconDataCenter(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: IconButton(
          onPressed: () => _navigateToDataCenterPage(context),
          icon: Image.asset(
            'assets/images/icons/book_box.png',
            height: 55,
          ),
        ),
      ),
    );
  }

  Widget iconSevenCode(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: IconButton(
          onPressed: () => _navigateToSevenCodePage(context),
          icon: Image.asset(
            'assets/images/icons/orb_box.png',
            height: 55,
          ),
        ),
      ),
    );
  }

  Widget iconHints(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: IconButton(
          onPressed: () => _navigateToHintsPage(context),
          icon: Image.asset(
            'assets/images/icons/light_bulb_box.png',
            height: 55,
          ),
        ),
      ),
    );
  }
}
