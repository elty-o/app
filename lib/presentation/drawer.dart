import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/globals.dart';
import 'package:flutter_application_1/features/use_case_1/about.dart';
//import 'package:flutter_application_1/features/use_case_1/profile_update.dart';
import 'package:flutter_application_1/features/use_case_3/account_removal.dart';
import 'package:flutter_application_1/features/use_case_1/login.dart';
//import 'package:flutter_application_1/features/newsfeeds.dart';
import 'package:flutter_application_1/features/use_case_2/notifications.dart';
import 'package:flutter_application_1/features/use_case_2/satisfaction_survey.dart';
// TODO: ROUTE -> To be finalised
import 'package:flutter_application_1/features/use_case_2/settings.dart';
import 'package:flutter_application_1/features/use_case_1/about_us_info.dart';
import 'package:flutter_application_1/features/use_case_3/faq.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
//import 'package:provider/provider.dart';

class DrawerDesign {
  bool checked = false;

  Drawer mainDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text(
          //         'Logged in: ${GlobalVariables().username} ${GlobalVariables().userSurname}',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 18,
          //         ),
          //       ),
          //       //SizedBox(height: 5),
          //       GlobalVariables().loggedIn
          //           ? Text(
          //               'Username: ${GlobalVariables().userEmail}',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 14,
          //               ),
          //             )
          //           : Text(''),
          //     ],
          //   ),
          // ),
          Container(
            height: 100,
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalVariables().loggedIn
                    ? Text(
                        '${GlobalVariables().username} ${GlobalVariables().userSurname}\n${GlobalVariables().userEmail}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    : Text(
                        AppLocalizations.of(context)!.not_logged_in,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text(AppLocalizations.of(context)!.about_us),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsInfo()));
            },
          ),
          ListTile(
            leading: Icon(Icons.phone_in_talk_outlined),
            title: Text(AppLocalizations.of(context)!.contact),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notifications()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.newspaper_rounded),
          //   title: Text(AppLocalizations.of(context)!.news_feeds),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/webpage',
          //         arguments: {'url': 'https://www.sanews.gov.za/'});
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => NewsFeeds()));
          //   },
          // ),

          ListTile(
            leading: Icon(Icons.file_present_outlined),
            title: Text(AppLocalizations.of(context)!.legal_documents),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUs()));
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text(AppLocalizations.of(context)!.faq),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FAQ()));
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text(AppLocalizations.of(context)!.feedback),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SatisfactionSurvey()));
            },
          ),

          ListTile(
            leading: Icon(Icons.bar_chart_rounded),
            title: Text(AppLocalizations.of(context)!.reports),
            onTap: () {
              Navigator.pushNamed(context, '/webpage',
                  arguments: {'url': '${GlobalVariables().report}'});
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => NewsFeeds()));
            },
          ),
          //TODO: ROUTES: Currently 405 is being displayed
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          // GlobalVariables().loggedIn
          //     ? ListTile(
          //         leading: Icon(Icons.update),
          //         title: Text('Update Profile'),
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => ProfileUpdate()));
          //         },
          //       )
          //     : Container(),
          ListTile(
            leading: Icon(Icons.person_outline_sharp),
            title: GlobalVariables().loggedIn
                ? Text(AppLocalizations.of(context)!.logout)
                : Text(AppLocalizations.of(context)!.login),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          GlobalVariables().loggedIn
              ? ListTile(
                  textColor: Colors.red,
                  leading: Icon(
                    Icons.manage_accounts_outlined,
                    color: Colors.red,
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.deleteAccountDrawerTitle),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountRemoval()));
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
