import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_gpt/app/errors/failure.dart';
import 'package:scan_gpt/feature/detector/domain/repositories/detector_repository.dart';

@injectable
class OCRFromCameraUseCase {
  OCRFromCameraUseCase({required DetectorRepository detectorRepository}) : _detectorRepository = detectorRepository;

  final DetectorRepository _detectorRepository;

  Future<Either<Failure, String>> call() {
    return _detectorRepository.ocrFromCamera();
  }
}
