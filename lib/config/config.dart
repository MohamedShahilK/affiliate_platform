abstract class Flavor {}

class Development extends Flavor {}

// class Staging extends Flavor {}

class Production extends Flavor {}

enum AppMode {
  debug,
  release,
  profile,
}

class Config {
  Config._();

  static Flavor? appFlavor;
  static AppMode appMode = _getCurrentMode();

  static AppMode _getCurrentMode() {
    AppMode mode;

    // bool isDebug = false;
    var isDebug = false;
    assert(isDebug = true, 'isDebug must be true in debug Mode');

    if (isDebug) {
      mode = AppMode.debug;
    } else if (const bool.fromEnvironment('dart.vm.product')) {
      mode = AppMode.release;
    } else {
      mode = AppMode.profile;
    }

    return mode;
  }
}
