import 'package:flutter/material.dart';
import 'package:fluttertask/next_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 70.0, top: 30.0, right: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 30),
            const Text(
              'Please select your Language',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'You can change the language',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Text(
              'at any time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            const LanguageDropdown(),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: ElevatedButton(
                onPressed: () {
                  if (languageProvider.selectedLanguage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NextPage(), //go to next page
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a language.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E3B62),
                  minimumSize: const Size(216, 48),
                ),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final String? selectedLanguage = languageProvider.selectedLanguage;

    List<String> languages = ['English', 'Spanish', 'French'];

    return DropdownButtonFormField<String>(
      value: selectedLanguage,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (String? newValue) {
        languageProvider.selectedLanguage = newValue;
      },
      items: languages.map<DropdownMenuItem<String>>((String language) {
        return DropdownMenuItem<String>(
          value: language,
          child: Text(language),
        );
      }).toList(),
    );
  }
}

class LanguageProvider with ChangeNotifier {
  String? _selectedLanguage;

  String? get selectedLanguage => _selectedLanguage;

  set selectedLanguage(String? value) {
    _selectedLanguage = value;
    notifyListeners();
  }
}
