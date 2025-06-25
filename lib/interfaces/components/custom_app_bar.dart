import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String image;
  final List<Color> backgroundColor;
  final bool textBlack;

  const CustomAppBar({
    super.key,
    required this.titleText,
    required this.image,
    required this.backgroundColor,
    required this.textBlack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        titleText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textBlack ? Colors.black : Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            image,
            height: 50,
            color: textBlack ? Colors.black : Colors.white,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          color: textBlack ? Colors.black : Colors.white,
          height: 2.0,
        ),
      ),
    );
  }
}