import 'package:dartz/dartz.dart';

import '../../../../core/shared/resource/failures.dart';
import '../entities/cat_fact_entity.dart';

/// An abstract repository class for cat facts contract methods
abstract class CatRepository {
  /// A contract method for getting cat facts
  Future<Either<Failure, List<CatFactEntity>>> getCatFacts();
}
