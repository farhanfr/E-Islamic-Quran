import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/images.dart' as AppImage;
import 'package:e_islamic_quran/utils/transitions.dart' as AppTrans;
import 'package:e_islamic_quran/utils/extensions.dart' as AppExt;

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final bool disabled;
  final bool isUpperCase;
  final Widget leading;
  final bool _isContained;
  final Color textColor;
  final double elevation;
  final bool isCompact;
  final bool isSmall;
  final bool isLoading;
  final Color hoverColor;
  final Color splashColor;
  final Color highlightColor;

  RoundedButton.contained({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.color,
    this.disabled = false,
    this.isUpperCase = true,
    this.textColor,
    this.elevation = 4,
    this.isCompact = false,
    this.isSmall = false,
    this.isLoading = false,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
  })  : this.leading = null,
        this._isContained = true,
        super(key: key);

  RoundedButton.outlined({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.color,
    this.disabled = false,
    this.isUpperCase = true,
    this.leading,
    this.textColor,
    this.elevation,
    this.isCompact = false,
    this.isSmall = false,
    this.isLoading = false,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
  })  : this._isContained = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color buildColor = color ?? AppColor.primaryAppDark;

    return _isContained
        ? buildContained(buildColor)
        : buildOutlined(buildColor, leading);
  }

  ElevatedButton buildContained(Color buildColor) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled))
              return AppColor.roundedButtonDisabled;
            return buildColor;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) return hoverColor;
            if (states.contains(MaterialState.pressed)) return splashColor;
            return null;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled))
              return AppColor.textSecondary;
            return textColor ?? AppExt.computeTextColor(buildColor);
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.all(0.0),
        ),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) {
            return Colors.black38;
          },
        ),
        elevation: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return 0;
            if (states.contains(MaterialState.pressed)) return 1;
            return this.elevation;
          },
        ),
      ),
      onPressed: disabled || isLoading ? null : onPressed,
      child: Container(
        margin: isCompact
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
            : const EdgeInsets.all(12),
        child: Center(
          child: AppTrans.SharedAxisTransitionSwitcher(
            transitionType: SharedAxisTransitionType.vertical,
            fillColor: Colors.transparent,
            child: !isLoading
                ? Text(
                    isUpperCase ? label.toUpperCase() : label,
                    style: AppTypo.button.copyWith(
                        letterSpacing: isUpperCase ? 1.25 : 0,
                        fontSize: isSmall ? 14 : 16,
                        fontWeight: disabled || onPressed == null
                            ? FontWeight.w500
                            : FontWeight.w700),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(buildColor))),
          ),
        ),
      ),
    );
  }

  Widget buildOutlined(Color buildColor, Widget leading) {
    return OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //   (Set<MaterialState> states) {
          //     return Colors.transparent;
          //   },
          // ),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered)) return hoverColor;
              if (states.contains(MaterialState.pressed)) return splashColor;
              return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled))
                return AppColor.textSecondary;
              return textColor ?? AppExt.computeTextColor(buildColor);
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(0.0),
          ),
          shadowColor: MaterialStateProperty.resolveWith(
            (states) {
              return Colors.black38;
            },
          ),
          side: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled))
              return BorderSide(
                  color: AppColor.roundedButtonDisabled, width: 2);
            return BorderSide(color: buildColor, width: 2);
          }),
          elevation: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) return 0;
              if (states.contains(MaterialState.pressed)) return 1;
              return this.elevation;
            },
          ),
        ),
        child: Container(
          margin: isCompact
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : const EdgeInsets.all(12),
          child: Stack(children: [
            Center(
              child: Text(
                isUpperCase ? label.toUpperCase() : label,
                style: AppTypo.button.copyWith(
                  color: disabled || onPressed == null
                      ? Colors.grey[400]
                      : textColor ?? buildColor,
                  fontSize: isSmall ? 14 : 16,
                  fontWeight: disabled || onPressed == null
                      ? FontWeight.w500
                      : FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            leading != null
                ? Positioned(top: 0, bottom: 0, left: 10, child: leading)
                : SizedBox.shrink(),
          ]),
        ));
  }

}