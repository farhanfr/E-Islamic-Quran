import 'package:flutter/material.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/images.dart' as AppImage;

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: _screenWidth * 10/100),
          children: [
            Center(
                child: Text("E-Islamic Quran",
                    style: AppTypo.h2.copyWith(color: AppColor.primaryAppDark))),
            Center(
                child: Text("Version - Bahasa Indonesia",
                    style: AppTypo.body2.copyWith(
                        color: AppColor.textSecondary,
                        fontWeight: FontWeight.bold))),
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                ),
                        );
                      }
                    }))
            // Container(
            //   child: ,
            // )
          ],
        ),
      ),
    );
  }
}
