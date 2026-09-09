import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../di/mall_dependencies.dart';
import '../../domain/entities/product_filter.dart';
import '../state/mall_state.dart';

final mallViewModelProvider =
    NotifierProvider.autoDispose<MallViewModel, MallState>(MallViewModel.new);

class MallViewModel extends AutoDisposeNotifier<MallState> {
  @override
  MallState build() {
    final products = ref.watch(getProductsProvider)();
    return MallState(
      products: products,
      visibleProducts: ref.watch(filterProductsProvider)(
        products,
        const ProductFilter(),
      ),
    );
  }

  void setQuery(String query) =>
      applyFilters(state.filter.copyWith(query: query));
  void applyFilters(ProductFilter filter) {
    state = MallState(
      products: state.products,
      filter: filter,
      visibleProducts: ref.read(filterProductsProvider)(state.products, filter),
    );
  }

  void resetFilters() => applyFilters(const ProductFilter());
}
