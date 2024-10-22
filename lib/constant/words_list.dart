  import 'package:speech_therapy/model/word.dart';
import 'package:speech_therapy/utils/images_path.dart';

import '../utils/audio_paths.dart';

final List<Word> words = [
  Word('Thank you', ImagePaths.thankYou,AudioPaths.thankYou),
  Word('Please', ImagePaths.please,AudioPaths.please),
  Word('Eat', ImagePaths.eat,AudioPaths.eat),
  Word('Sleep', ImagePaths.sleep,AudioPaths.sleep),
  
  Word('I’m walking', ImagePaths.walking,AudioPaths.walking),
  Word('I’m eating', ImagePaths.eat,AudioPaths.eat),
  Word('I’m playing', ImagePaths.playing, AudioPaths.playing),
  Word('I’m Drinking', ImagePaths.drinking, AudioPaths.drinking),
  Word('I’m Sleeping', ImagePaths.sleep, AudioPaths.sleep),
  Word('I’m Running', ImagePaths.running, AudioPaths.running),
  
  Word('Fever', ImagePaths.fever, AudioPaths.fever),
  Word('First Aid', ImagePaths.firstAid, AudioPaths.firstAid),
  Word('Doctor', ImagePaths.doctor, AudioPaths.doctor),
  Word('Medicine', ImagePaths.medicine, AudioPaths.medicine),
  
  Word('Mango', ImagePaths.mango, AudioPaths.mango),
  Word('Banana', ImagePaths.banana, AudioPaths.banana),
  Word('Apple', ImagePaths.apple, AudioPaths.apple),
  Word('Orange', ImagePaths.orange, AudioPaths.orange),
];

final List<Word> commonWords = [
  Word('Thank you', ImagePaths.thankYou,  AudioPaths.thankYou),
  Word('Please', ImagePaths.please, AudioPaths.please),
  Word('Eat', ImagePaths.eat, AudioPaths.eat),
  Word('Sleep', ImagePaths.sleep, AudioPaths.sleep),
];

final List<Word> sentence = [
  Word('I’m walking', ImagePaths.walking, AudioPaths.walking),
  Word('I’m eating', ImagePaths.eat,  AudioPaths.eat),
  Word('I’m playing', ImagePaths.playing, AudioPaths.playing),
  Word('I’m Drinking', ImagePaths.drinking, AudioPaths.drinking),
  Word('I’m Sleeping', ImagePaths.sleep,  AudioPaths.sleep),
  Word('I’m Running', ImagePaths.running, AudioPaths.running),
];

final List<Word> hospitalWords = [
  Word('Fever', ImagePaths.fever, AudioPaths.fever),
  Word('First Aid', ImagePaths.firstAid, AudioPaths.firstAid),
  Word('Doctor', ImagePaths.doctor, AudioPaths.doctor),
  Word('Medicine', ImagePaths.medicine, AudioPaths.medicine),
];

final List<Word> fruits = [
  Word('Mango', ImagePaths.mango, AudioPaths.mango),
  Word('Banana', ImagePaths.banana, AudioPaths.banana),
  Word('Apple', ImagePaths.apple, AudioPaths.apple),
  Word('Orange', ImagePaths.orange, AudioPaths.orange),
];