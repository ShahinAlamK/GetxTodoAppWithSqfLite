import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController{

  final box=GetStorage();

  TextEditingController userNameController = TextEditingController();
  var _username=''.obs;
  RxString get username=>_username;


  void userValid(){
    if(userNameController.text.isEmpty){
      Get.snackbar("Required", "Username can't be empty please",
          colorText: Colors.white,
          backgroundColor:Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10,right: 10,left: 10),
      );
    }else{
      storageName(userNameController.text);
      Get.back();
      update();
    }
  }


  @override
  void onInit() {
    readeName();
    super.onInit();
  }

  void storageName(String name){
    box.write("username", name);
    readeName();
    update();
  }

  void readeName(){
    var name=box.read("username");
    _username.value=name??"";
    update();
  }
}