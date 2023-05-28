import 'package:dartz/dartz.dart';
import 'package:scan_gpt/app/errors/failure.dart';
import 'package:scan_gpt/feature/detector/domain/entities/detector/detector_entity.dart';

abstract class DetectorRepository {
  Future<Either<Failure, DetectorEntity>> detect(String userInput);
  Future<Either<Failure, String>> ocrFromGallery();
  Future<Either<Failure, String>> ocrFromCamera();
}
