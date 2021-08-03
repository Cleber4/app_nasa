import 'package:app_nasa/core/errors/failures.dart';
import 'package:app_nasa/core/usecase/usecase.dart';
import 'package:app_nasa/features/domain/entities/space_media_entity.dart';
import 'package:app_nasa/features/domain/repositories/space_media_repository.dart';
import 'package:dartz/dartz.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date);
  }
}
