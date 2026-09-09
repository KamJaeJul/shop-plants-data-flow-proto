import '../entities/home_content.dart';
import '../repositories/location_launcher.dart';

class OpenStoreLocation {
  const OpenStoreLocation(this.launcher);
  final LocationLauncher launcher;
  Future<bool> call(StoreLocation location) async {
    try {
      return await launcher.open(location);
    } catch (_) {
      return false;
    }
  }
}
