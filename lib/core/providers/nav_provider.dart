import 'package:flutter/foundation.dart';

class NavProvider extends ChangeNotifier {
  bool _menuOpen = false;
  bool get menuOpen => _menuOpen;

  void openMenu()  { _menuOpen = true;  notifyListeners(); }
  void closeMenu() { _menuOpen = false; notifyListeners(); }
  void toggleMenu() { _menuOpen = !_menuOpen; notifyListeners(); }
}
