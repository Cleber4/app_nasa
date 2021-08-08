import 'package:app_nasa/core/errors/exceptions.dart';
import 'package:app_nasa/core/errors/failures.dart';
import 'package:app_nasa/features/data/datasourcer/space_media_datasource.dart';
import 'package:app_nasa/features/data/models/space_media_model.dart';
import 'package:app_nasa/features/data/repositories/space_media_repository_implementations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MoskISpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MoskISpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'Test de Decription: OK',
    mediaType: 'Test Image: OK',
    title: 'Test Title: OK',
    mediaUrl: 'Test MediaUrl: OK',
  );

  final tDate = DateTime(2021, 8, 2);
  test("Retorne Sucesso no Space Media Model quando chamar o Datasource",
      () async {
    // Fazendo Mock
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    // Fazendo a Ação chamando repositorio
    final result = await repository.getSpaceMediaFromDate(tDate);

    // Verificando resultudado do Datasource
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test("Retorne falha no servidor quando chamar o Datasource", () async {
    // Fazendo Mock
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    // Fazendo a Ação chamando repositorio
    final result = await repository.getSpaceMediaFromDate(tDate);

    // Verificando resultudado do Datasource
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
