import 'package:injectable/injectable.dart';
import 'package:scan_gpt/app/errors/exceptions.dart';
import 'package:scan_gpt/core/clients/network/network_client.dart';
import 'package:scan_gpt/feature/detector/data/model/detector/detector_model.dart';

@injectable
class DetectorRemoteDataSource {
  DetectorRemoteDataSource({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;
  final NetworkClient _networkClient;

  Future<DetectorModel> detect(String userInput) async {
    try {
      final response = await _networkClient.post<Map<String, dynamic>>(
        'https://c5d03e39a0f9.ngrok.app/api/score',
        data: {'text': userInput},
      );
      final model = response.data;
      if (model == null) {
        throw NetworkException();
      } else {
        return DetectorModel.fromJson(model);
      }
    } catch (_) {
      throw NetworkException();
    }
  }
}
