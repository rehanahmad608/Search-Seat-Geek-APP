abstract class BasePath {}

mixin BaseNav {
  BasePath get homePath;
  BasePath get currentPath;

  BaseNav? get parent;
  void routeTo(BasePath state);
  void pop() {
    final isUpperLevel = currentPath == homePath;
    final parentNav = parent;
    if (isUpperLevel && parentNav != null) {
      parentNav.pop();
    } else {
      routeTo(homePath);
    }
  }
}
