abstract final class AppRoutes {
  static const home = '/';
  static const mall = '/mall';
  static const discover = '/discover';
  static const inbox = '/inbox';
  static const account = '/account';

  static String? forNavigationIndex(int index) => switch (index) {
    0 => home,
    1 => mall,
    2 => discover,
    3 => inbox,
    4 => account,
    _ => null,
  };
}
