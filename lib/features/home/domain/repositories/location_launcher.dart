import '../entities/home_content.dart';

abstract interface class LocationLauncher {
  Future<bool> open(StoreLocation location);
}
