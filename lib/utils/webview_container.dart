import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewContainer extends StatefulWidget {
  const WebViewContainer({
    required this.url,
    required this.title,
    this.html,
    super.key,
  });

  final String url;
  final String title;
  final String? html;
  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  final _key = UniqueKey();
  bool isLoading = true;
  final controller = WebViewController();

  @override
  void initState() {
    super.initState();

    if (widget.html != null) {
      controller.loadHtmlString(widget.html!);
      setState(() {
        isLoading = false;
      });
    } else {
      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
              // CircularProgressIndicator(color: Colors.black,);
              // Container(color: Colors.red,height: 500,width: 100,);
              //print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.title, style: GoogleFonts.lora(color: Colors.black)),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            key: _key,
            controller: controller,
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
