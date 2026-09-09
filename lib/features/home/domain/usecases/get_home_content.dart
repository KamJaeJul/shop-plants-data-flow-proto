import '../entities/home_content.dart';
import '../repositories/home_repository.dart';

class GetHomeContent {
  const GetHomeContent(this.repository);
  final HomeRepository repository;
  HomeContent call() => repository.getContent();
}
