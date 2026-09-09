import '../../domain/entities/home_content.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';

class LocalHomeRepository implements HomeRepository {
  const LocalHomeRepository(this.source);
  final HomeLocalDataSource source;
  @override
  HomeContent getContent() => source.load();
}
