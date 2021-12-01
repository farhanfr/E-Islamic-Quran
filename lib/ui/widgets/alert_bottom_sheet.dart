import 'package:e_islamic_quran/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/extensions.dart' as AppExt;

class AlertBottomSheet{
  static Future show(BuildContext context,
      {String title,
      String description,
      IconData icon,
      Color color,
      bool isDismissible = true,
      bool isWithBackButton = false
      }) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    AppExt.hideKeyboard(context);
    await showModalBottomSheet(
      isDismissible: isDismissible ,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Icon(
                      icon ?? Icons.check_circle_outline,
                      color: color ?? AppColor.primaryApp,
                      size: 55,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTypo.h3,
                    ),
                    Text(description,
                        textAlign: TextAlign.center,
                        style: AppTypo.subtitle2Accent),
                    SizedBox(
                      height: 10,
                    ),
                    isWithBackButton == true ?
                    RoundedButton.outlined(
                        label: "Kembali",
                        isUpperCase: false,
                        isSmall: true,
                        onPressed: () {
                          AppExt.popScreen(context,true);
                        }) : SizedBox()

                  ],
                ),
              ],
            ),
          );
        });
    return;
  }
}


