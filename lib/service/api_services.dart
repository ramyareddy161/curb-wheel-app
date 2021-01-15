import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:turf/turf.dart';

part 'api_services.chopper.dart';

class Config {
  final String projectId;
  final String projectName;
  final String email;
  final String mapData;
  final String organization;

  Config(this.projectId, this.projectName, this.email, this.mapData,
      this.organization);

  Config.fromJson(Map<String, dynamic> json)
      : projectId = json['projectId'],
        projectName = json['projectName'],
        email = json['email'],
        mapData = json['mapData'],
        organization = json['organization'];
}

class MapData {
  final FeatureCollection featureCollection;

  MapData(this.featureCollection);

  MapData.fromJson(Map<String, dynamic> json)
      : featureCollection = FeatureCollection.fromJson(json);
}

@ChopperApi()
abstract class JsonService extends ChopperService {
  static JsonService create([ChopperClient client]) => _$JsonService(client);

  @Get(path: '{url}')
  Future<Response> getJson(@Path('url') String url);
}
