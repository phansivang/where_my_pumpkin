import 'package:dartz/dartz.dart';

import '../../../../core/shared/resource/failures.dart';
import '../../../../core/shared/resource/usecase.dart';
import '../entities/cat_fact_entity.dart';
import '../repositories/cat_repository.dart';

/// A use case class to get cat facts
class GetCatFactsUseCase extends UseCase<List<CatFactEntity>, NoParams> {
  /// A repository class for cat facts
  final CatRepository repository;

  /// Creates an instance of [GetCatFactsUseCase]
  GetCatFactsUseCase(this.repository);
  @override
  Future<Either<Failure, List<CatFactEntity>>> call(NoParams params) =>
      repository.getCatFacts();
}
