import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../di/home_dependencies.dart';
import '../../domain/entities/home_content.dart';
import '../state/home_state.dart';

final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeNotifier<HomeState> {
  @override
  HomeState build() => HomeState(ref.watch(getHomeContentProvider)());
  Future<bool> openLocation(StoreLocation location) =>
      ref.read(openStoreLocationProvider)(location);
}
