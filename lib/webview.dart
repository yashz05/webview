import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview/config.dart';
import 'package:webview/loading.dart';

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
  bool loading_s = false;

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
                if (value == 0) {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: Uri.parse(config.url)));
                } else if (value == 1) {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: Uri.parse(config.url2)));
                } else if (value == 2) {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: Uri.parse(config.url3)));
                }
              },
              currentIndex: start,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Google"),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Flutter",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.abc),
                    label: "Gihtub",
                  ),
                ])
          : SizedBox(),
      appBar: config.app_bar == true
          ? AppBar(
              centerTitle: false,
              title: Text(title),
              actions: [
                IconButton(
                    onPressed: () async {
                      if (Platform.isAndroid) {
                        webViewController?.reload();
                      } else if (Platform.isIOS) {
                        webViewController?.loadUrl(
                            urlRequest: URLRequest(
                                url: await webViewController?.getUrl()));
                      }
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    ))
              ],
            )
          : AppBar(
              toolbarHeight: 0,
            ),
      backgroundColor: bg,
      body: Stack(children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(config.url)),
          onLoadStop: (controller, url) {
            controller.getTitle().then((value) {
              setState(() {
                title = value.toString();
                loading_s = false;
              });
            });
          },
          onLoadStart: (controller, url) {
            setState(() {
              loading_s = true;
            });
          },
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        ),
        loading_s == true ? loading() : SizedBox()
      ]),
    );
  }

  //backend
  chane_name(String Name) {
    setState(() {
      title = Name;
    });
  }
}
