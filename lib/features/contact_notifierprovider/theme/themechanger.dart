import 'package:flutter_riverpod/flutter_riverpod.dart';

class Themechange extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void switcher() {
    state = !state;
  }
}

final themeProvider = NotifierProvider<Themechange, bool>(() => Themechange());
