import 'package:e_islamic_quran/ui/screens/screens.dart';
import 'package:e_islamic_quran/ui/widgets/rounded_button.dart';
import 'package:e_islamic_quran/utils/get_storage_ext.dart';
import 'package:flutter/material.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/images.dart' as AppImage;
import 'package:e_islamic_quran/utils/extensions.dart' as AppExt;

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isGetStartedClicked;
  bool hasLastRead = false;

  Map<String,dynamic> dataAyat;

  @override
  void initState() {
    isGetStartedClicked = false;
    if (GetStorageExt().getStorageRead("keyDataAyat") != null) {
      dataAyat= GetStorageExt().getStorageRead("keyDataAyat");
      hasLastRead=true;
      print(GetStorageExt().getStorageRead("keyDataAyat").toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth * 10 / 100),
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _screenWidth * 10 / 100,
              ),
              Center(
                  child: Text("E-Islamic Quran",
                      style:
                          AppTypo.h2.copyWith(color: AppColor.primaryAppDark))),
              Center(
                  child: Text("Version - Bahasa Indonesia",
                      style: AppTypo.body2.copyWith(
                          color: AppColor.textSecondary,
                          fontWeight: FontWeight.bold))),
              SizedBox(
                height: _screenWidth * 10 / 100,
              ),
              isGetStartedClicked == false ?
              Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                          image: AssetImage(AppImage.img_landing_screen),
                          width: double.infinity,
                          errorBuilder: (context, object, stack) => Image.asset(
                                AppImage.img_error,
                                width: double.infinity,
                              ),
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            } else {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: frame != null
                                    ? child
                                    : Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[200],
                                        ),
                                      ),
                              );
                            }
                          })),
                  SizedBox(
                    height: _screenWidth * 10 / 100,
                  ),
                  RoundedButton.contained(
                      label: "Jelajah",
                      isUpperCase: false,
                      onPressed: () {
                        setState(() {
                          isGetStartedClicked = true;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  RoundedButton.outlined(
                      label: "Tutup Aplikasi",
                      isUpperCase: false,
                      onPressed: () {
                        print("object");
                      }),
                ],
              ) :
              MenuItem(
                hasLastRead:hasLastRead,
                dataLastRead: dataAyat,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key key, this.hasLastRead, this.dataLastRead}) : super(key: key);

  final bool hasLastRead;
  final Map<String,dynamic> dataLastRead;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedButton.outlined(
          label: "Baca Quran",
          isUpperCase: false,
          onPressed: (){
            AppExt.pushScreen(context, ListSurahScreen());
          }
        ),
        SizedBox(height: hasLastRead ? 20 : 0,),
        hasLastRead ?
        RoundedButton.outlined(
          label: "Terakhir Dibaca",
          isUpperCase: false,
          onPressed: (){
            AppExt.pushScreen(context, DetailAyatScreen(numberSurah: dataLastRead['numberSurah'], numberAyat: dataLastRead['ayat']));
          }
        ):SizedBox(),
        SizedBox(height: 20,),
        RoundedButton.outlined(
          label: "Baca Tafsir", 
          isUpperCase: false,
          onPressed: (){
            //
          }
        ),
        SizedBox(height: 20,),
        RoundedButton.outlined(
          label: "Tentang Aplikasi", 
          isUpperCase: false,
          onPressed: (){
            //
          }
        ),
      ],
    );
  }
}
