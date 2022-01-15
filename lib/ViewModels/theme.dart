import 'package:flutter/cupertino.dart';
import 'package:pegsolitaire/Core/Enums/audio.dart';
import 'package:pegsolitaire/Core/Services/Storage/user_settings.dart';

class AppTheme extends ChangeNotifier {
  bool darkMode = false;
  bool autoMove = false;
  Audio audio = Audio.sound;
  int color = 0;
  int shape = 0;
  AppTheme() {
    loadData();
  }

  Future<void> loadData() async {
    darkMode = await UserSettingsBox.loadDarkMode();
    print("loaded dark mode = " + darkMode.toString());
    autoMove = await UserSettingsBox.loadAutoMove();
    audio = await UserSettingsBox.loadAudio();
    color = await UserSettingsBox.loadColor();
    shape = await UserSettingsBox.loadShape();
    notifyListeners();
  }

  void darkModeChaneged() {
    darkMode = !darkMode;
    notifyListeners();
    UserSettingsBox.saveDarkMode(darkMode);
  }

  void autoMoveChaneged() {
    autoMove = !autoMove;
    notifyListeners();
    UserSettingsBox.saveAutoMove(autoMove);
  }

  void audioChaneged(Audio value) {
    if (audio != value) {
      audio = value;
      notifyListeners();
      UserSettingsBox.saveAudio(audio);
    }
  }

  void colorChaneged(int value) {
    if (color != value) {
      color = value;
      notifyListeners();
      UserSettingsBox.saveColor(color);
    }
  }

  void shapeChaneged(int value) {
    if (shape != value) {
      shape = value;
      notifyListeners();
      UserSettingsBox.saveShape(color);
    }
  }
}
