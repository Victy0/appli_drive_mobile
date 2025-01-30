import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class SevenCodePage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const SevenCodePage({super.key, required this.onLanguageChange});

  @override
  SevenCodePageState createState() => SevenCodePageState();
}

class SevenCodePageState extends State<SevenCodePage>{
  void _returnToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
          HomePage(onLanguageChange: widget.onLanguageChange, initSound: false),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0);
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
          BackgroundImage(color: "purple"),
          Center(
            child: Text("7code page")
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
              Color.fromARGB(255, 212, 0, 255),
              Color.fromARGB(255, 162, 50, 253),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          _returnToHomePage(context);
        },
      ),
      centerTitle: true,
      title: const Text(
        "7code",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () => (),
          icon: Image.asset(
            'assets/images/icons/orb_box.png',
            height: 50,
            color: Colors.white,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          color: Colors.white,
          height: 2.0,
        ),
      ),
    );
  }
}
