import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUsInfo extends StatefulWidget {
  const AboutUsInfo({super.key});

  @override
  State<AboutUsInfo> createState() => _AboutUsInfoState();
}

class _AboutUsInfoState extends State<AboutUsInfo> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion =
          'Version: ${packageInfo.version} '; // (${packageInfo.buildNumber})
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDesign().noDrawerAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 800,
                height: 50,
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.about_us_header,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gill')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.about_us_content_header,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Gill'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context)!.about_us_paragraph_one,
                          style: TextStyle(fontSize: 16)),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Text(
                      //     'Our innovative platform has been meticulously designed to cater to every citizen\'s needs, covering the entire life cycle from birth to beyond. We are thrilled to announce the launch of this groundbreaking initiative, ensuring that all South Africans have convenient access to essential digital government services.',
                      //     textAlign: TextAlign.justify),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Text(
                      //     'The South African e-Services app is your one-stop destination for a multitude of services that shape and support your life. Categories such as Health, Education, Agriculture & Land, Sport, Arts and Culture, Business & Economic Activity, Consumer Protection, Citizenship & Immigration, Employment & Labour, Environment, Money & Tax, Legal & Defence, Housing & Local Services, Transport, Social Services, and Retirement & Death have been meticulously curated to address the diverse needs of our citizens.',
                      //     textAlign: TextAlign.justify),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.about_us_paragraph_two,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image(image: AssetImage('assets/feature_graphic.jpg'))
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('App Version: $_appVersion'),
              ),
            ],
          ),
        ));
  }
}
