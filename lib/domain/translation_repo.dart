// lib/data/repositories/translation_repository.dart
import 'dart:async';

abstract class TranslationRepository {
  Future<String?> translateText(String text,context);
}
