import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:flutter_application_1/features/use_case_1/registration_detail.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool checked = false;
  bool newCheck = false;
  Future<void> openWebBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String specificPDF = "";

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 800,
              height: 50,
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    AppLocalizations.of(context)!.termsAndConditionsAppBarTitle,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gill')),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 350,
                child: Column(
                  children: [
                    Flexible(
                      child: Text(
                          AppLocalizations.of(context)!.termsDescription,
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Flexible(
                        child: Text(
                            AppLocalizations.of(context)!.personalDashboard)),
                    Flexible(
                        child: Text(
                            AppLocalizations.of(context)!.applyForServices)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.orange,
                              value: checked,
                              onChanged: (value) {
                                setState(() {
                                  checked = value!;
                                });
                              }),
                          Flexible(
                            child: GestureDetector(
                              // onTap: () {
                              //   openWebBrowser(
                              //       GlobalVariables().termsAndConditions);
                              // },
                              onTap: () async {
                                File file = await createFileOfPdfUrl(
                                    GlobalVariables().termsAndConditions);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PDFScreen(path: file.path),
                                  ),
                                );
                              },
                              child: Text(
                                  maxLines: 2,
                                  AppLocalizations.of(context)!
                                      .termsAndConditionsText),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.orange,
                            value: newCheck,
                            onChanged: (value) {
                              setState(() {
                                newCheck = value!;
                              });
                            }),
                        GestureDetector(
                          // onTap: () {
                          //   openWebBrowser(GlobalVariables().privacy);
                          // },
                          onTap: () async {
                            File file = await createFileOfPdfUrl(
                                GlobalVariables().privacy);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFScreen(path: file.path),
                              ),
                            );
                          },
                          child: Text(
                              maxLines: 2,
                              AppLocalizations.of(context)!.privacyPolicyText),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.cancelButton,
                              style: TextStyle(color: Colors.white),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                if (checked && newCheck) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationDetail()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .acceptTermsAndConditions),
                                    ),
                                  );
                                  //debugPrint('Not checked');
                                }
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.continueButton,
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
