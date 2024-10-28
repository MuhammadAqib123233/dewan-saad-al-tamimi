import 'package:get/get.dart';

class HomePageController extends GetxController{
  bool isloading = true;
  String url = "https://dewansaadaltamimi.com/";
  int index = 0;
  loadview(){
    isloading = false;
    update();
  }
  navigateTo(String Url){
    url = Url;
    print(url);
    isloading=true;
    update();
  }
}