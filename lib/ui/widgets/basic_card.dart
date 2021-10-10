import 'package:flutter/material.dart';
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;

class BasicCard extends StatelessWidget {
  const BasicCard({ Key key , @required this.child, this.width, this.isBordered = false, this.color = Colors.white, this.hasShadow = true, this.radius = 7.5, this.height}) : super(key: key);

  final Widget child;
  final double width,height,radius;
  final Color color;
  final bool isBordered,hasShadow;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
         color: color ?? Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: isBordered == true ? Border.all(
          width: 1,
          color: Colors.grey[400],
        ) : null,
        boxShadow: isBordered == true || hasShadow == false ? null : <BoxShadow>[
          BoxShadow(
            color: AppColor.textSecondary2.withOpacity(0.45),
            blurRadius: 5,
          ),
        ] 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(7.5),
        ),
        child: child,
      ),
    );

  }
}