import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scan_gpt/app/errors/failure.dart';
import 'package:scan_gpt/feature/detector/domain/entities/detector/detector_entity.dart';
import 'package:scan_gpt/feature/detector/domain/repositories/detector_repository.dart';
import 'package:scan_gpt/feature/detector/domain/use_cases/detect_use_case.dart';

class MockDetectorRepository extends Mock implements DetectorRepository {}

class MockDetectorEntity extends Mock implements DetectorEntity {}

void main() {
  late MockDetectorRepository mockDetectorRepository;
  late DetectUseCase detectUseCase;
  late MockDetectorEntity mockDetectorEntity;
  late String userInput;

  setUp(() {
    mockDetectorRepository = MockDetectorRepository();
    detectUseCase = DetectUseCase(detectorRepository: mockDetectorRepository);
    mockDetectorEntity = MockDetectorEntity();
    userInput = 'Test Input';
  });

  group('Detect Use Case Test', () {
    test('Should return a single instance of a Detector Entity when no exception caught', () async {
      when(() => mockDetectorRepository.detect(userInput)).thenAnswer((_) async => Right(mockDetectorEntity));
      final result = await detectUseCase(userInput);

      verify(() => detectUseCase(userInput));
      expect(result, isA<Right<Failure, DetectorEntity>>());
    });

    test('Should return Failure type of object when an exception caught', () async {
      when(() => mockDetectorRepository.detect(userInput))
          .thenAnswer((_) async => const Left(Failure.networkFailure()));
      final result = await detectUseCase(userInput);

      verify(() => detectUseCase(userInput));
      expect(result, isA<Left<Failure, DetectorEntity>>());
    });
  });
}
