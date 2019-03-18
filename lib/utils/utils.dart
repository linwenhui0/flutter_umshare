class Print {
  static Print _instance = Print._();
  static bool debug = true;

  Print._();

  factory Print() {
    return _instance;
  }

  printNative(Object object) {
    if (debug) {
      print(object);
    }
  }
}
