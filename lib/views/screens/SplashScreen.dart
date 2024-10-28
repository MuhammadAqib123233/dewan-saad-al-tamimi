import 'package:dewan/controller/HomepageController.dart';
import 'package:dewan/controller/SplashScreenCOntroller.dart';
import 'package:dewan/controller/WebDataController.dart';
import 'package:dewan/views/screens/ForwardScreen.dart';
import 'package:dewan/views/screens/Homepage.dart';
import 'package:dewan/views/screens/VideoScreen.dart';
import 'package:dewan/views/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  InAppWebViewController? _firstWebViewController;
  bool isLoading = true;
   @override
  void initState(){
    super.initState();
    _loadWebView();
  }
  @override
  Widget build(BuildContext context) {
  //    widgets = [
  //             InAppWebView(
  //           initialUrlRequest: URLRequest(url: Uri.parse("https://dewansaadaltamimi.com/photos")),
  //           initialOptions: InAppWebViewGroupOptions(
            
  //           ),
  //            onProgressChanged: (controller, progress) async{
  //             if(progress == 100){
  //               await controller.evaluateJavascript(source: _injectJavascriptCode());
  //             }
  //           },
  //         ),
  //          InAppWebView(
  //           initialUrlRequest: URLRequest(url: Uri.parse("https://dewansaadaltamimi.com/videos")),
  //           initialOptions: InAppWebViewGroupOptions(
            
  //           ),
  //           onLoadStop: (controller, url)async{
  //             await controller.evaluateJavascript(source: _injectJavascriptCode());
  //             isLoading = false;
  //             setState(() {});
  //           },
  //         ),
  //            InAppWebView(
  //           initialUrlRequest: URLRequest(url: Uri.parse("https://dewansaadaltamimi.com/")),
  //           initialOptions: InAppWebViewGroupOptions(
            
  //           ),
  //           onProgressChanged: (controller, progress) async{
  //             if(progress == 100.0){
  //               await controller.evaluateJavascript(source: _injectJavascriptCode());
  //             }
  //           },
  //         ),
  //         if(isLoading)
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: MediaQuery.of(context).size.height,
  //             color: AppColors().primaryColor,
  //             child: Center(
  //               child: Image.asset("assets/images/dewan-logo.jpeg", width: 200, height: 200,),
  //             ),
  //           ),
  // ];
    // Future.delayed(
    //   const Duration(seconds: 5),
    //   (){
    //     Get.to(()=>HomePage(html: "",));
    //   }
    // );
        return Scaffold(
        backgroundColor: AppColors().primaryColor,
        body: Stack(
          children: [
             Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors().primaryColor,
              child: Center(
                child: Image.asset("assets/images/dewan-logo.jpeg", width: 200, height: 200,),
              ),
            ),
          ]
        ),
        bottomNavigationBar: BottomAppBar(
      height: 70,
  color: AppColors().primaryColor,
  elevation: 0, // Remove elevation to make icons align at the center
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Horizontally center the icons
      crossAxisAlignment: CrossAxisAlignment.center, // Vertically center the icons
      children: [
    InkWell(
      onTap: (){
       // Get.to(()=>ForwardScreen());
      //  _reorderWidgets(0, widgets.length - 1);
      },
      child: Icon(Icons.forward,
      color: Colors.white.withOpacity(0.6),
      size: 30,
      ),
    ), // Add spacing between icons
    InkWell(
       onTap: (){
          Get.to(()=>ForwardScreen());
      },
      child: Icon(Icons.play_arrow,
      color: Colors.white.withOpacity(0.6),
      size: 30,
      ),
    ),
   InkWell(
    onTap: (){
       Get.to(()=>VideoScreen());
      },
      child: Icon(Icons.camera_alt,
      color: Colors.white.withOpacity(0.6),
      size: 30,
      ),
   ),
   InkWell(
    onTap: (){
        Get.to(()=>HomePage(html: ""));
      },
      child: Icon(Icons.home,
      color: Colors.white,
      size: 30,
      ),
   )
      ],
    ),
  ),
),
      );
  }

  String _injectJavascriptCode() {
    return '''
      document.getElementById("masthead").style.display="none";
      document.getElementById('colophon').style.display = 'none';
    ''';
  }

  Future<void> _loadWebView() async {
   WebDataController webCon = Get.find<WebDataController>();
     webCon.homecontroller = await WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://dewansaadaltamimi.com/'));
     webCon.photoScreenController = await WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://dewansaadaltamimi.com/photos'));
   webCon.videoScreenCOntroller = await WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://dewansaadaltamimi.com/videos'));
   webCon.forwardController = await WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://reach.link/dewansaadaltamimi'));
    Future.delayed(
      const Duration(seconds: 5),
      (){
        Get.to(()=>HomePage(html: "",));
      }
    );
  }
}