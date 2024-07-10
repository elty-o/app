import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _selectedLanguage = 'en';
  Map<String, String> _languages = {
    'zu': 'Zulu',
    'xh': 'Xhosa',
    'af': 'Afrikaans',
    'fr': 'French',
    'nl': 'Dutch',
    // 'nso': 'Northern Sotho',
    // 'st': 'Southern Sotho',
    // 'tn': 'Tswana',
    // 'ts': 'Tsonga',
    // 'ss': 'Swati',
    // 've': 'Venda',
    // 'nr': 'Ndebele',
    'en': 'English',
  };

  String get selectedLanguage => _selectedLanguage;
  Map<String, String> get languages => _languages;

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    final Map<String, Locale> _languages = {
      'English': const Locale('en'),
      'Afrikaans': const Locale('af'),
      'Chinese': const Locale('zh'),
      'French': const Locale('fr'),
      'Gujarati': const Locale('gu'),
      'Urdu': const Locale('ur'),
      //'Xhosa': const Locale('ts'),
      'Zulu': const Locale('zu'),
    };

    void _changeLanguage(String languageCode) {
      final locale = _languages[languageCode];
      if (locale != null) {
        localeProvider.setLocale(locale);
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 800,
              height: 50,
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context)!.settings_header,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gill')),
              ),
            ),

            //THIS IS THE TRANSLATOR
            Column(
              children: _languages.keys.map((String languageCode) {
                return ListTile(
                  title: Text(languageCode),
                  onTap: () => _changeLanguage(languageCode),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
