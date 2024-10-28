import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebDataController extends GetxController{
  RxString homeContent = "".obs;
  var homecontroller = WebViewController();
  var photoScreenController =  WebViewController();
  var videoScreenCOntroller = WebViewController();
  var  forwardController = WebViewController();
}