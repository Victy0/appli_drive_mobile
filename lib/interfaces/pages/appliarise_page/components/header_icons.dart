import 'package:flutter/material.dart';

class HeaderIcons extends StatefulWidget {
  final String grade;
  const HeaderIcons({super.key, required this.grade});

  @override
  HeaderIconsState createState() => HeaderIconsState();
}

class HeaderIconsState extends State<HeaderIcons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, bottom: 16, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.grade == "standard")
            iconPairing(context),
          const Spacer(),
          iconAppmonListCode(context)
        ],
      ),
    );
  }

  Widget iconPairing(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () => showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: const Center( 
              child: Text(
                'Título',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            content: const SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Contexto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.check_box_sharp,
                  size: 40.0,
                  color: Colors.green,
                )
              ),
            ],
          ),
        ),
        icon: Image.asset(
          'assets/images/icons/link_box.png',
          height: 40,
        ),
      )
    );
  }

  Widget iconAppmonListCode(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () => showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: const Center( 
              child: Text(
                'Título',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            content: const SizedBox(
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Contexto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.check_box_sharp,
                  size: 40.0,
                  color: Colors.green,
                )
              ),
            ],
          ),
        ),
        icon: Image.asset(
          'assets/images/icons/list_box.png',
          height: 40,
        ),
      ),
    );
  }
}
