import 'package:e_islamic_quran/data/models/ayat.dart';

class FormValidations {

  String pattern = r'(^[a-zA-Z ]*$)';
  String patternDigits = r'(^[0-9]*$)';
  
  String ayatInput(String value){
    RegExp regExp = new RegExp(patternDigits);
    if (value.length == 0) {
      return "Nomor ayat harus diisi";
    } 
    else if (!regExp.hasMatch(value)) {
      return "Input harus berupa angka";
    }
    return null;

  }

}