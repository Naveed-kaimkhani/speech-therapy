import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/provider/language_provider.dart';


class LanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return DropdownButton<String>(
      value: languageProvider.language,
      items: [
        const DropdownMenuItem(value: "en-US", child: Text("English")),
        const DropdownMenuItem(value: "ur-PK", child: Text("Urdu")),
      ],
      onChanged: (value) {
        if (value != null) {
          languageProvider.setLanguage(value);
        }
      },
    );
  }
}
