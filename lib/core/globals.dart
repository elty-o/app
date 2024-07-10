// globals.dart

//import 'package:flutter/material.dart';

class GlobalVariables {
  static GlobalVariables _instance = GlobalVariables._internal();

  factory GlobalVariables() {
    return _instance;
  }

  GlobalVariables._internal();

  // LOCAL Server
  //static String server = 'http://192.168.8.101:8080';
  //static String local = 'http://192.168.8.100';

  // BETA Server
  //static String server = 'https://beta.eservices.gov.za';

  // UAT2 Server
  //static String uat = 'https://uat2.eservices.gov.za';

  // PRODUCTION Server
  static String server = 'https://www.eservices.gov.za';

  // ROUTES
  String sendOtpEndPoint = '$server/tonkana/rest/members/sending';
  String registerUserEndPoint = '$server/tonkana/rest/users/adduser';
  String validateNewUserEndPoint = '$server/tonkana/rest/members/validateuser';
  String validFromSer = '$server/tonkana/rest/users/adduser';
  String phpUserRegistration = '$server/tnk/registrationservice.php';
  String updateUserPasswordEndPoint = '$server/rest/members/updatepassword';
  String userAuthentication = '$server/tonkana/rest/users/authenticate/';
  String resetPassword = '$server/rest/members/resetpassword/';
  String updatePassword = '$server/rest/members/updatepassword';
  String requestUsernameOtpEndPoint = '$server/rest/members/forgotusername';
  String updateUsernameEndPoint = '$server/rest/users/updateusername';
  String updateUserProfile = '$server/tonkana/rest/users/updateuser';
  String changeUserPassword = '$server/tonkana/rest/users/passwordchange';
  String survey = '$server/tnk/eservicesmobilesurvey.php';
  String deleteUserAccount =
      '$server/tonkana/rest/users/removeUserAccount/'; //TODO: USER DELETION ROUTE REQUIRED!
  //String report = '$server/tonkana/reports/uniqueLogins.jsf';
  String report = '$server/tonkana/reports/uniqueLogins.jsf';

  bool loggedIn = false;
  String languageTo = '';
  String languageFrom = 'en';
  String language = 'en';

  String globalUrl = '';

  String user = '';

  String forgotPasswordOtp = '';
  String forgotUsernameOtp = '';

  int userId = 0;
  String token = '';
  String username = '';
  String secondName = '';
  String thirdName = '';
  String userSurname = '';
  String location = '';
  String cellphoneNumber = '';
  String userEmail = '';
  String idNumber = '';
  String passpord = '';

  int responseCode = 200;

  Map<String, String> userData = {};

  // static String server = 'http://10.122.39.19';
  //static String local = 'http://192.168.8.100';
  // String sendOtpEndPoint = '$server/opt.php';
  // String registrationEndPoint = '$server/tonkana/registrationservice.php';
  // String registerUserEndPoint = '$server/tonkana/registrationservice.php';
  // String validateNewUserEndPoint = '$server/tonkana/validatenewuser.php';
  //String phpUserRegistration = '$local/tonkana/registrationservice.php';

  //About us links
  final termsAndConditions =
      'https://www.sita.co.za/sites/default/files/documents/terms_conditions/website%20terms%20and%20conditions_ZP.pdf';
  final paia =
      'https://www.sita.co.za/sites/default/files/documents/PAIA%20Manual%202020%20FINAL.pdf';
  final privacy =
      'https://www.sita.co.za/sites/default/files/documents/SITA%20website%20privacy%20policy%20and%20cookie%20policy%20-%20FINAL%20NRG%2018%2006%202020.pdf';
  //e-Services Hyper Links
  final urlPrenatalCare = 'https://www.gov.za/services/birth/prenatal-care';
  final urlPaternityTest = 'https://www.gov.za/services/birth/paternity-test';
  final urlChildImmunization =
      'https://www.gov.za/services/child-care/child-immunisation';
  final urlDFFE = '${server}/cips/epermit?id=';
  final urlFSEPermit = "${server}/epermit-fs-destea/epermit?id=";
  final urlECPermit = "${server}/epermit-ec-dedeat/epermit?id=";
  final urlKZNPermit = "${server}/epermit-kzn/epermit?id=";
  final urlLimpopoPermit = "${server}/epermit-lm-ledet/epermit?id=";
  final urlRehab = "${server}/e-Rehab/rehab?id=";
  final urlFSEcomplaints = "${server}/ecomplaint-fs-destea/ecomplaint?id=";
  final urlNols = "https://nols.gov.za/dhetnols/sso.php?id=";
  final urlLTSM = "${server}/LTSM/OTP/Index?id=";
  final urlSitaRecruitment = "${server}/eRecruitmentCitizen/Account/Login?id=";
  final urlKZNRecruitment =
      "${server}/eRecruitmentCitizenKZN/Account/Login?id=";
  final urlPEA = "${server}/pea/applicant/index.html?id=";
  final urlDhet = "${server}/eparticipation/eparticipation?id=";
  final urlFSON = "${server}/fs-son/epermit?id=";
  final urlSITAComplaint = "${server}/ecomplaints-sita/ecomplaint?id=";
  final urlLandServices = "${server}/epglum/epermit?id=";
  final urlHSN = '${server}/hsnc/eregister?id=';
}
