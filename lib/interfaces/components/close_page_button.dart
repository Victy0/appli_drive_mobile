import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class ClosePageButton extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const ClosePageButton({super.key, required this.onLanguageChange});

  @override
  ClosePageButtonState createState() => ClosePageButtonState();
}

class ClosePageButtonState extends State<ClosePageButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(onLanguageChange: widget.onLanguageChange, initSound: false),
                ));
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}