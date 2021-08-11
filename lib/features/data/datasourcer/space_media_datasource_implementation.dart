import 'dart:convert';

import 'package:app_nasa/core/errors/exceptions.dart';
import 'package:app_nasa/core/http_client/http_client.dart';
import 'package:app_nasa/core/utils/converters/data_to_string_converter.dart';
import 'package:app_nasa/core/utils/keys/nasa_api_keys.dart';
import 'package:app_nasa/features/data/datasourcer/endpoints/nasa_api_endpoints.dart';
import 'package:app_nasa/features/data/datasourcer/space_media_datasource.dart';
import 'package:app_nasa/features/data/models/space_media_model.dart';

class NasaDatasourceImplements implements ISpaceMediaDatasource {
  final HttpClient client;

  NasaDatasourceImplements(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaApiEndpoints.apod(
        NasaApiKeys.apiKey, DateToStringConverter.convert(date)));

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
