import 'package:hive/hive.dart';
import 'package:pegsolitaire/Core/Enums/audio.dart';

class UserSettingsBox {
  static Box? box;
  static const String boxName = "boxName settings";
  static const String darkMode = "darkMode";
  static const String autoMove = "autoMove";
  static const String audio = "audio";
  static const String color = "color";
  static const String shape = "shape";

  // Init User Settings HIve Box

  static Future<void> init_box() async {
    box = box ?? await Hive.openBox(boxName);
  }

  // Dark Mode

  static Future<void> saveDarkMode(bool value) async {
    await init_box();
    box!.put(darkMode, value);
  }

  static Future<bool> loadDarkMode() async {
    await init_box();
    return box!.get(darkMode) ?? false;
  }

  // Auto Move

  static Future<void> saveAutoMove(bool value) async {
    await init_box();
    box!.put(autoMove, value);
  }

  static Future<bool> loadAutoMove() async {
    await init_box();
    return box!.get(autoMove) ?? false;
  }

  // Audio

  static Future<void> saveAudio(Audio value) async {
    await init_box();
    box!.put(audio, value.index);
  }

  static Future<Audio> loadAudio() async {
    await init_box();
    int res = await box!.get(audio) ?? 1;
    return Audio.values[res];
  }

  // Peg Color

  static Future<void> saveColor(int value) async {
    await init_box();
    box!.put(color, value);
  }

  static Future<int> loadColor() async {
    await init_box();
    return box!.get(color) ?? 0;
  }

  // Peg Shape

  static Future<void> saveShape(int value) async {
    await init_box();
    box!.put(shape, value);
  }

  static Future<int> loadShape() async {
    await init_box();
    return box!.get(shape) ?? 0;
  }
}
