class Votes {
  int windows;
  int apple;

  Votes({
    required this.windows,
    required this.apple
  });

  getWindowsPercent() {
    return (windows * 100 / (windows + apple)).round();
  }

  getApplePercent() {
    return (apple * 100 / (windows + apple)).round();
  }
}