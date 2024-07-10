import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

final String termsAndConditions =
    'https://www.sita.co.za/sites/default/files/documents/terms_conditions/website%20terms%20and%20conditions_ZP.pdf';
final String paia =
    'https://www.sita.co.za/sites/default/files/documents/PAIA%20Manual%202020%20FINAL.pdf';
final String privacy =
    'https://www.sita.co.za/sites/default/files/documents/SITA%20website%20privacy%20policy%20and%20cookie%20policy%20-%20FINAL%20NRG%2018%2006%202020.pdf';

Future<void> openWebBrowser(String url) async {
  debugPrint('THIS IS URL: $url');
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

class _AboutUsState extends State<AboutUs> {
  String specificPDF = "";

  Future<File> createFileOfPdfUrl(String pdfURL) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = pdfURL;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              height: 30,
              image: AssetImage('assets/appbar/appbar.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Image(
              height: 30,
              image: AssetImage('assets/appbar/ndp.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Image(
              height: 30,
              image: AssetImage('assets/appbar/saflag.png'),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 800,
                    height: 50,
                    color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          AppLocalizations.of(context)!
                              .about_us_legal_documents,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gill')),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.security_outlined),
                    onTap: () {
                      Navigator.pushNamed(context, '/webpage', arguments: {
                        'url':
                            'https://sites.google.com/view/eservices-privacy-policy/home'
                      });
                    },
                    title: Text(AppLocalizations.of(context)!
                        .about_us_services_privacy_policy),
                  ),
                  ListTile(
                    leading: Icon(Icons.work_outline_outlined),
                    onTap: () async {
                      File file = await createFileOfPdfUrl(termsAndConditions);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: file.path),
                        ),
                      );
                    },
                    title: Text(AppLocalizations.of(context)!
                        .about_us_terms_and_conditions),
                  ),
                  ListTile(
                    leading: Icon(Icons.policy_outlined),
                    onTap: () async {
                      File file = await createFileOfPdfUrl(paia);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: file.path),
                        ),
                      );
                    },
                    title: Text(AppLocalizations.of(context)!.about_us_paia),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    onTap: () async {
                      File file = await createFileOfPdfUrl(privacy);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: file.path),
                        ),
                      );
                    },
                    title: Text(
                        AppLocalizations.of(context)!.about_us_sita_privacy),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign().noDrawerAppBar(),
      body: Stack(
        children: <Widget>[
          PDFView(
            fitEachPage: true,
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: false,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.WIDTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      // floatingActionButton: FutureBuilder<PDFViewController>(
      //   future: _controller.future,
      //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
      //     if (snapshot.hasData) {
      //       return FloatingActionButton.extended(
      //         label: Text("Go to ${pages! ~/ 2}"),
      //         onPressed: () async {
      //           await snapshot.data!.setPage(pages! ~/ 2);
      //         },
      //       );
      //     }

      //     return Container();
      //   },
      // ),
    );
  }
}
