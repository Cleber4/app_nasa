import 'dart:convert';

import 'package:app_nasa/features/data/models/space_media_model.dart';
import 'package:app_nasa/features/domain/entities/space_media_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description:
        "What's the best way to watch a meteor shower? This question might come up later this week when the annual Perseid Meteor Shower peaks. One thing that is helpful is a dark sky, as demonstrated in the featured composite image of last year's Perseids. Many more faint meteors are visible on the left image, taken through a very dark sky in Slovakia, than on the right image, taken through a moderately dark sky in the Czech Republic. The band of the Milky Way Galaxy bridges the two coordinated images, while the meteor shower radiant in the constellation of Perseus is clearly visible on the left. In sum, many faint meteors are lost through a bright sky. Light pollution is shrinking areas across our Earth with dark skies, although inexpensive ways to combat this might be implemented. Notable Perseids Submissions to APOD: 2018, 2019, 2020",
    mediaType: "image",
    title: "Perseus and the Lost Meteors",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2108/PerseidsLost_SlovinskyHoralek_1080.jpg",
  );

  test("Deve ser uma SubClasse do SpaceMediaEntity", () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test("Deve retornar um Modelo Válido", () {
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    final result = SpaceMediaModel.fromJson(jsonMap);

    expect(result, tSpaceMediaModel);
  });

  test("Deve retornar Map json contendo dados adequados", () {
    final expectedMap = {
      "explanation":
          "What's the best way to watch a meteor shower? This question might come up later this week when the annual Perseid Meteor Shower peaks. One thing that is helpful is a dark sky, as demonstrated in the featured composite image of last year's Perseids. Many more faint meteors are visible on the left image, taken through a very dark sky in Slovakia, than on the right image, taken through a moderately dark sky in the Czech Republic. The band of the Milky Way Galaxy bridges the two coordinated images, while the meteor shower radiant in the constellation of Perseus is clearly visible on the left. In sum, many faint meteors are lost through a bright sky. Light pollution is shrinking areas across our Earth with dark skies, although inexpensive ways to combat this might be implemented. Notable Perseids Submissions to APOD: 2018, 2019, 2020",
      "media_type": "image",
      "title": "Perseus and the Lost Meteors",
      "url":
          "https://apod.nasa.gov/apod/image/2108/PerseidsLost_SlovinskyHoralek_1080.jpg"
    };

    final result = tSpaceMediaModel.toJson();

    expect(result, expectedMap);
  });
}
