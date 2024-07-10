import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_application_1/presentation/appbar.dart';

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  WebPageState createState() => WebPageState();
}

class WebPageState extends State<WebPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String url = args['url'];
    //final String name = args['name'];
    debugPrint('$url THIS IS THE URL');
    return Scaffold(
      appBar: _isLoading ? null : AppBarDesign().noDrawerAppBar(),
      body: Stack(
        children: [
          WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: Image(
                      image: AssetImage('assets/appbar/appbar.png'),
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
