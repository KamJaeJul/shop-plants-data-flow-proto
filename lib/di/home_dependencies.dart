import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/home/data/datasources/home_local_data_source.dart';
import '../features/home/data/repositories/local_home_repository.dart';
import '../features/home/data/services/google_maps_launcher.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/repositories/location_launcher.dart';
import '../features/home/domain/usecases/get_home_content.dart';
import '../features/home/domain/usecases/open_store_location.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => const LocalHomeRepository(HomeLocalDataSource()),
);
final locationLauncherProvider = Provider<LocationLauncher>(
  (ref) => const GoogleMapsLauncher(),
);
final getHomeContentProvider = Provider(
  (ref) => GetHomeContent(ref.watch(homeRepositoryProvider)),
);
final openStoreLocationProvider = Provider(
  (ref) => OpenStoreLocation(ref.watch(locationLauncherProvider)),
);
