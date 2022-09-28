import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview/config.dart';

class webvi extends StatefulWidget {
  const webvi({super.key});

  @override
  State<webvi> createState() => _webviState();
}

class _webviState extends State<webvi> {
  String title = "Webview";
  Color bg = Colors.white;
  final GlobalKey webViewKey = GlobalKey();
  int start = 0;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: config.bottom_nav == true
          ? BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  start = value;
                });

                if (value == 1) {
                  setState(() {
                    print(value);
                    // print('change');
                    webViewController?.loadUrl(
                        urlRequest: URLRequest(
                            url: Uri.parse(
                                "https://example.com/api/fetch?limit=10,20,30&max=100")));
                  });
                }
              },
              currentIndex: start,
              items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Gihtub",
                  )
                ])
          : SizedBox(),
      appBar: AppBar(
        centerTitle: false,
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  webViewController?.reload();
                } else if (Platform.isIOS) {
                  webViewController?.loadUrl(
                      urlRequest:
                          URLRequest(url: await webViewController?.getUrl()));
                }
              },
              icon: Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: bg,
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(config.url2)),
        onLoadStop: (controller, url) {
          controller.getTitle().then((value) {
            setState(() {
              title = value.toString();
            });
          });
          // setState(() {
          //   // title = controller.getTitle().toString();
          // });
        },
        onLoadStart: (controller, url) {},
      ),
    );
  }

  //backend
  chane_name(String Name) {
    setState(() {
      title = Name;
    });
  }
}
