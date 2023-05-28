import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_gpt/app/errors/failure.dart';
import 'package:scan_gpt/feature/detector/domain/entities/detector/detector_entity.dart';
import 'package:scan_gpt/feature/detector/domain/repositories/detector_repository.dart';

@injectable
class DetectUseCase {
  DetectUseCase({
    required DetectorRepository detectorRepository,
  }) : _detectorRepository = detectorRepository;

  final DetectorRepository _detectorRepository;

  Future<Either<Failure, DetectorEntity>> call(String userInput) {
    return _detectorRepository.detect(userInput);
  }
}
