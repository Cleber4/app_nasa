import 'package:app_nasa/features/data/models/space_media_model.dart';

abstract class ISpaceMediaDatasource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);
}
