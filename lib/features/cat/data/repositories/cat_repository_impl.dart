import 'package:dartz/dartz.dart';

import '../../../../core/shared/resource/exceptions.dart';
import '../../../../core/shared/resource/failures.dart';
import '../../domain/entities/cat_fact_entity.dart';
import '../../domain/repositories/cat_repository.dart';
import '../datasources/cat_remote_data_source.dart';

/// An implementation class of [CatRepository]
class CatRepositoryImpl implements CatRepository {
  /// An instance of [CatRemoteDataSource]
  final CatRemoteDataSource remoteDataSource;

  /// Creates an instance of [CatRepositoryImpl]
  CatRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<CatFactEntity>>> getCatFacts() async {
    try {
      final catFacts = await remoteDataSource.getCatFacts();
      return Right(catFacts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(LocalAppFailure(e.toString()));
    }
  }
}
