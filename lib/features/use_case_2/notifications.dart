import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 800,
              height: 50,
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context)!.contact_us_header,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gill')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.e_services_phone),
                leading: const Icon(
                  Icons.phone_outlined,
                  color: Colors.green,
                ),
                subtitle: const Text('080 141 4882'),
                onTap: () async {
                  // String phoneNumber = '0801414882';
                  // String url = 'tel:$phoneNumber';

                  // if (await canLaunchUrl(Uri.parse(url))) {
                  //   await launchUrl(Uri.parse(url));
                  // } else {
                  //   throw 'Could not launch $url';
                  // }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.e_services_email),
                leading: const Icon(
                  Icons.email_outlined,
                  color: Colors.green,
                ),
                subtitle: const Text('egovsupport@sita.co.za'),
                onTap: () async {
                  // sendEmail();
                },
              ),
            ),
            Container(
              width: 800,
              height: 50,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    AppLocalizations.of(context)!.emergency_contact_us_header,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gill')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.police),
                leading: const Icon(
                  Icons.spatial_audio_off_outlined,
                  color: Colors.red,
                ),
                subtitle: const Text('10111'),
                onTap: () async {
                  // String phoneNumber = '0801414882';
                  // String url = 'tel:$phoneNumber';

                  // if (await canLaunchUrl(Uri.parse(url))) {
                  //   await launchUrl(Uri.parse(url));
                  // } else {
                  //   throw 'Could not launch $url';
                  // }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.ambulance),
                leading: const Icon(
                  Icons.local_hospital_outlined,
                  color: Colors.red,
                ),
                subtitle: const Text('10177'),
                onTap: () async {
                  // String phoneNumber = '0801414882';
                  // String url = 'tel:$phoneNumber';

                  // if (await canLaunchUrl(Uri.parse(url))) {
                  //   await launchUrl(Uri.parse(url));
                  // } else {
                  //   throw 'Could not launch $url';
                  // }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.fire_brigade),
                leading: const Icon(
                  Icons.fire_truck_outlined,
                  color: Colors.red,
                ),
                subtitle: const Text('112'),
                onTap: () async {
                  // String phoneNumber = '0801414882';
                  // String url = 'tel:$phoneNumber';

                  // if (await canLaunchUrl(Uri.parse(url))) {
                  //   await launchUrl(Uri.parse(url));
                  // } else {
                  //   throw 'Could not launch $url';
                  // }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.poisonControl),
                leading: const Icon(
                  Icons.dangerous_sharp,
                  color: Colors.red,
                ),
                subtitle: const Text('0861 555 777'),
                onTap: () async {
                  // String phoneNumber = '0801414882';
                  // String url = 'tel:$phoneNumber';

                  // if (await canLaunchUrl(Uri.parse(url))) {
                  //   await launchUrl(Uri.parse(url));
                  // } else {
                  //   throw 'Could not launch $url';
                  // }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.childLineSouthAfrica),
                leading: const Icon(
                  Icons.child_care,
                  color: Colors.red,
                ),
                subtitle: const Text('0800 055 555'),
                onTap: () async {
                  // String phoneNumber = '0801414882';
                  // String url = 'tel:$phoneNumber';

                  // if (await canLaunchUrl(Uri.parse(url))) {
                  //   await launchUrl(Uri.parse(url));
                  // } else {
                  //   throw 'Could not launch $url';
                  // }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.genderBasedViolence),
                leading: const Icon(
                  Icons.back_hand,
                  color: Colors.red,
                ),
                subtitle: const Text('0800 428 428'),
                onTap: () async {
                  String phoneNumber = '0800428428';
                  String url = 'tel:$phoneNumber';

                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void sendEmail() async {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'egovsupport@sita.co.za',
  //   );

  //   if (await canLaunchUrl(emailLaunchUri)) {
  //     await launchUrl(emailLaunchUri);
  //   } else {
  //     throw 'Could not launch $emailLaunchUri';
  //   }
  // }
}
