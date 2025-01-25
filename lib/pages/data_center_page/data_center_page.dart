import 'package:flutter/material.dart';

class DataCenterPage extends StatefulWidget {
  const DataCenterPage({super.key});

  @override
  DataCenterPageState createState() => DataCenterPageState();
}

class DataCenterPageState extends State<DataCenterPage>{

  @override
  Widget build(BuildContext context) {    
    return const Scaffold(
      backgroundColor: Color.fromARGB(244, 223, 223, 223),
      body: Center(
        child: Text("Data center page")
      ),
    );
  }
}
