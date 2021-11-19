import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:e_islamic_quran/ui/screens/screens.dart';
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;

void main() async {  
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Islamic-Quran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: AppColor.primaryApp,
        fontFamily: 'Poppins'
      ),
      home: LandingScreen()
    );
  }
}

