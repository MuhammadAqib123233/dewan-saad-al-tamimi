import 'package:dewan/controller/SplashScreenCOntroller.dart';
import 'package:dewan/controller/WebDataController.dart';
import 'package:dewan/views/screens/ForwardScreen.dart';
import 'package:dewan/views/screens/PhotoScreen.dart';
import 'package:dewan/views/screens/VideoScreen.dart';
import 'package:dewan/views/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  final String html;
  const HomePage({super.key, required this.html});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   bool _isLoading = true;
    double _progress = 0.0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadWebView();
  }
  @override
  Widget build(BuildContext context) {
   WebDataController webCon = Get.find<WebDataController>();
    webCon.homecontroller.runJavaScript(
      '''
      document.getElementById("masthead").style.display="none";
      document.getElementById('colophon').style.display = 'none';
'''
    );
    return Scaffold(
      appBar:  AppBar(
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
         // WebViewWidget(controller: controller)
  //          InAppWebView(
  //           initialData: InAppWebViewInitialData(data: webcontroller.homeContent.value, mimeType : "text/html",
  // encoding :"utf8",),
  //           initialOptions: InAppWebViewGroupOptions(
            
  //           ),
  //           onLoadStart: (controller, url) {
  //             setState(() {
  //               _isLoading = true;
  //             });
  //           },
  //           onLoadStop: (controller, url)async{
  //             // Inject JavaScript to hide header and footer
  //                setState(() {
  //               _isLoading = false;
  //             });
  //             String? content = await controller.getHtml();
  //             print(content);
  //           },
  //           onProgressChanged: (controller, progress) async{
  //              setState(() {
  //               _progress = progress / 100;
  //              // Normalize progress to 0-1 range
  //             });
  //              if (progress == 100.0) {
  //               // Request is completed and HTML data is received
  //              //await controller.evaluateJavascript(source: _injectJavascriptCode());
  //               await _loadWebView();
  //             }
  //           },
  //         ),

  //          if (_isLoading)
  //           Container(
  //             height: MediaQuery.of(context).size.height,
  //             width: MediaQuery.of(context).size.width,
  //             color: Colors.white,
  //             child: Center(
  //               child: Container(
  //                 height: 80,
  //                 width: 80,
  //                 child: Stack(
  //                   children: [
  //                     Container(
  //                       height: 80,
  //                       width: 80,
  //                       child: CircularProgressIndicator(value: _progress, color: AppColors().primaryColor,)),
  //                     Positioned.fill(
  //                       child: Center(
  //                         child: Text(
  //                           '${(_progress * 100).toInt()}%',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 30,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
        WebViewWidget(controller: webCon.homecontroller)
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
      color: Colors.white.withOpacity(0.6),
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
  }
}