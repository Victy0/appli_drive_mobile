import 'package:flutter/material.dart';

class Square7Code extends StatefulWidget {
  final String code;
  final bool disabled;
  final bool hasAppliarise;
  const Square7Code({super.key, required this.code, required this.disabled, required this.hasAppliarise});

  @override
  Square7CodeState createState() => Square7CodeState();
}

class Square7CodeState extends State<Square7Code> {
  @override
  Widget build(BuildContext context) {
    return widget.disabled
      ? Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        )
      : Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                blurRadius: 15,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/7code/${widget.code}.png',
            fit: BoxFit.contain,
          ),
        );
  }
}
