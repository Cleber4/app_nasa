import 'package:app_nasa/core/errors/exceptions.dart';
import 'package:app_nasa/core/http_client/http_client.dart';
import 'package:app_nasa/core/utils/converters/data_to_string_converter.dart';
import 'package:app_nasa/features/data/datasourcer/space_media_datasource.dart';
import 'package:app_nasa/features/data/datasourcer/space_media_datasource_implementation.dart';
import 'package:app_nasa/features/data/models/space_media_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImplements(client);
  });

  final tDateTime = DateTime(2021, 02, 02);
  final urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-02-02';

  DateToStringConverter.convert(tDateTime);

  void successMock() {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(
          data: spaceMediaMock,
          statusCode: 200,
        ));
  }

  test("Mostre método Get com URL correto", () async {
    successMock();

    await datasource.getSpaceMediaFromDate(tDateTime);

    verify(() => client.get(urlExpected)).called(1);
  });

  test("Retorne SpaceMediaModel quando for Sucesso", () async {
    successMock();
    final tSpacemediaModelExpected = SpaceMediaModel(
      description:
          "What's the best way to watch a meteor shower? This question might come up later this week when the annual Perseid Meteor Shower peaks. One thing that is helpful is a dark sky, as demonstrated in the featured composite image of last year's Perseids. Many more faint meteors are visible on the left image, taken through a very dark sky in Slovakia, than on the right image, taken through a moderately dark sky in the Czech Republic. The band of the Milky Way Galaxy bridges the two coordinated images, while the meteor shower radiant in the constellation of Perseus is clearly visible on the left. In sum, many faint meteors are lost through a bright sky. Light pollution is shrinking areas across our Earth with dark skies, although inexpensive ways to combat this might be implemented. Notable Perseids Submissions to APOD: 2018, 2019, 2020",
      mediaType: "image",
      title: "Perseus and the Lost Meteors",
      mediaUrl:
          "https://apod.nasa.gov/apod/image/2108/PerseidsLost_SlovinskyHoralek_1080.jpg",
    );

    final result = await datasource.getSpaceMediaFromDate(tDateTime);

    expect(result, tSpacemediaModelExpected);
  });

  test("Devemos lançar uma ServerException(Exceção) quando não for sucesso",
      () async {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(
          data: "Algo está errado",
          statusCode: 400,
        ));

    final result = datasource.getSpaceMediaFromDate(tDateTime);

    expect(() => result, throwsA(ServerException()));
  });
}
