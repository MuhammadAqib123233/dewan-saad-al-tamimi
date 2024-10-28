import 'package:dewan/controller/WebDataController.dart';
import 'package:dewan/views/screens/ForwardScreen.dart';
import 'package:dewan/views/screens/Homepage.dart';
import 'package:dewan/views/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'PhotoScreen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
 double _progress = 0.0;
 bool _isLoading = true;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadWebView();
  }
  @override
  Widget build(BuildContext context) {
    WebDataController webCon = Get.find<WebDataController>();
     webCon.videoScreenCOntroller.runJavaScript(
      '''
      document.getElementById("masthead").style.display="none";
      document.getElementById('colophon').style.display = 'none';
'''
    );
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors().primaryColor,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Stack(children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "ديوان سعد التميمي",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            child: Container(
              height: AppBar().preferredSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Icon(Icons.person, color: AppColors().primaryColor, size: 25,),
                  ),
                          ),
                ],
              ),
            ))
        ]),
      ),
      body: Stack(
        children: [
          //  InAppWebView(
          //   initialUrlRequest: URLRequest(
          //     url: Uri.parse('https://dewansaadaltamimi.com/videos/'),
          //   ),
          //   onLoadStart: (controller, url) {
          //     setState(() {
          //       _isLoading = true;
          //     });
          //   },
          //   onLoadStop: (controller, url) {
          //     // Inject JavaScript to hide header and footer
          //     Future.delayed(const Duration(seconds: 3));
          //        setState(() {
          //       _isLoading = false;
          //     });
          //   },
          //   onProgressChanged: (controller, progress) async{
          //     setState(() {
          //       _progress = progress / 100;
          //     });
          //      if (progress == 100) {
          //       // Request is completed and HTML data is received
          //      await controller.evaluateJavascript(source: _injectJavascriptCode());
          //     }
          //   },
          // ),
          // if (_isLoading)
          //  Container(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     color: Colors.white,
          //     child: Center(
          //       child: Container(
          //         height: 50,
          //         width: 50,
          //         child: Stack(
          //           children: [
          //             Container(
          //               height: 72,
          //               width: 72,
          //               child: CircularProgressIndicator(value: _progress, color: AppColors().primaryColor,)),
          //             Positioned.fill(
          //               child: Center(
          //                 child: Text(
          //                   '${(_progress * 100).toInt()}%',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 20,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          WebViewWidget(controller: webCon.videoScreenCOntroller)
        ],
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
        Get.to(()=>ForwardScreen());
      },
      child: Icon(Icons.forward,
      color: Colors.white.withOpacity(0.6),
      size: 30,
      ),
    ), // Add spacing between icons
    InkWell(
       onTap: (){
        Get.to(()=>VideoScreen());
      },
      child: Icon(Icons.play_arrow,
      color: Colors.white,
      size: 30,
      ),
    ),
   InkWell(
    onTap: (){
        Get.to(()=>PhotoScreen());
      },
      child: Icon(Icons.camera_alt,
      color: Colors.white.withOpacity(0.6),
      size: 30,
      ),
   ),
   InkWell(
    onTap: (){
        Get.to(()=>HomePage(html: "",));
      },
      child: Icon(Icons.home,
      color: Colors.white.withOpacity(0.6),
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
  }
}