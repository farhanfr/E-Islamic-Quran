import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_islamic_quran/utils/colors.dart' as AppColor;
import 'package:e_islamic_quran/utils/typography.dart' as AppTypo;
import 'package:flutter_icons/flutter_icons.dart';


enum InputType { text, password, search, field, phone, option, price }

class EditText extends StatefulWidget {
  final String hintText;
  final String initialValue;
  final InputType inputType;
  final TextEditingController controller;
  final Function onChanged;
  final Function onFieldSubmitted;
  final Function validator;
  final AutovalidateMode autoValidateMode;
  final TextInputType keyboardType;
  final String prefixText;
  final TextAlign textAlign;
  final bool enabled;
  final Color fillColor;
  final void Function() onTap;
  final bool isLoading;
  final bool autofocus;
  final bool readOnly;
  final bool isAlwaysBordered;
  final bool isDense;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final int maxLength;
  final List<TextInputFormatter> inputFormatter;
  final FocusNode focusNode;

  const EditText({
    Key key,
    @required this.hintText,
    this.inputType = InputType.text,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.prefixText,
    this.textAlign,
    this.enabled = true,
    this.fillColor = AppColor.editText,
    this.onTap,
    this.isLoading = false,
    this.autofocus = false,
    this.readOnly = false,
    this.isAlwaysBordered = false,
    this.isDense = false,
    this.padding,
    this.textStyle,
    this.maxLength,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.initialValue,
    this.focusNode,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool _obscureText;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.inputType == InputType.password ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatter,
      autofocus: widget.autofocus,
      onTap: widget.onTap ?? null,
      readOnly: widget.inputType == InputType.option || widget.readOnly == true,
      focusNode: widget.focusNode ?? _focus,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLength: widget.maxLength,
      maxLines: widget.inputType == InputType.field ? 5 : 1,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autoValidateMode,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      initialValue: widget.initialValue,
      controller: widget.controller,
      style: widget.textStyle != null
          ? widget.enabled
              ? widget.textStyle
              : widget.textStyle.copyWith(color: Colors.grey)
          : widget.enabled
              ? AppTypo.body2
              : AppTypo.body2.copyWith(color: Colors.grey),
      obscureText: _obscureText,
      decoration: InputDecoration(
          counter: SizedBox.shrink(),
          isDense: widget.isDense,
          prefixIcon: widget.inputType == InputType.phone
                  ? _focus.hasFocus || widget.controller.text.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(20, 14, 5, 14),
                          child: Text(
                            '+62',
                            style: AppTypo.body2.copyWith(color: Colors.grey),
                          ))
                      : null
                  : null,
          // prefixIcon: ,
          contentPadding: widget.padding ??
              EdgeInsets.fromLTRB(
                  20,
                  14,
                  widget.inputType == InputType.password ||
                          widget.inputType == InputType.option ||
                          widget.inputType == InputType.search
                      ? 4
                      : 20,
                  14),
          hintText: widget.inputType == InputType.phone && _focus.hasFocus
              ? null
              : widget.hintText,
          filled: true,
          fillColor: widget.enabled && widget.isAlwaysBordered == true
              ? Colors.transparent
              : widget.enabled
                  ? widget.fillColor
                  : Colors.grey[300],
          disabledBorder: OutlineInputBorder(
            borderRadius:  BorderRadius.circular(30),
            borderSide: widget.isAlwaysBordered == true
                ? BorderSide(color: AppColor.grey, width: 1)
                : BorderSide(color: AppColor.editText, width: 0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: widget.isAlwaysBordered == true
                ? BorderSide(color: AppColor.grey, width: 1)
                : BorderSide(color: AppColor.editText, width: 0.0),
          ),
          enabled: widget.enabled,
          focusedBorder: OutlineInputBorder(
            borderRadius:  BorderRadius.circular(30),
            borderSide: widget.isAlwaysBordered == true
                ? BorderSide(color: AppColor.grey, width: 1)
                : BorderSide(color: AppColor.editText, width: 0.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColor.danger, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius:  BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColor.danger, width: 1),
          ),
          suffixIcon: widget.isLoading
              ? SizedBox(
                  width: 0,
                  height: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            AppColor.primaryApp)),
                  ))
              : widget.inputType == InputType.password ||
                      widget.inputType == InputType.option
                  ? Container(
                      margin: EdgeInsets.only(right: 15),
                      child: new GestureDetector(
                        onTap: widget.inputType == InputType.password
                            ? () => setState(() => _obscureText = !_obscureText)
                            : null,
                        child: widget.inputType == InputType.password
                            ? new Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColor.editTextIcon,
                              )
                            : widget.inputType == InputType.option
                                ? new Icon(
                                    FlutterIcons.chevron_down_mco,
                                    color: AppColor.editTextIcon,
                                  )
                                : SizedBox.shrink(),
                      ),
                    )
                  : widget.inputType == InputType.search
                      ? Icon(Icons.search, color: AppColor.primaryApp)
                      : null),
    );
  }
}
