import 'package:get_storage/get_storage.dart';

class GetStorageExt{
  
  String key = "THIS IS KEY";

  saveLastRead(Map<String, dynamic> obj){
    GetStorage().write("keyDataAyat", obj);
  }

  //General
  getStorageRead(String key){
    return GetStorage().read(key);
  }

}