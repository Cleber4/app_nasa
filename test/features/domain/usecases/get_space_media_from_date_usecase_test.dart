import 'package:app_nasa/core/errors/failures.dart';
// import 'package:app_nasa/core/usecase/usecase.dart';
import 'package:app_nasa/features/domain/entities/space_media_entity.dart';
import 'package:app_nasa/features/domain/repositories/space_media_repository.dart';
import 'package:app_nasa/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;

  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  final tSpaceMedia = SpaceMediaEntity(
    description: 'Test de Decription: OK',
    mediaType: 'Test Image: OK',
    title: 'Test Title: OK',
    mediaUrl: 'Test MediaUrl: OK',
  );

  final tDate = DateTime(2021, 8, 2);

  test('Recebendo dados do repositório pelo Space Media Entity', () async {
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => Right<Failure, SpaceMediaEntity>(tSpaceMedia));
    final result = await usecase(tDate);
    expect(result, Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
