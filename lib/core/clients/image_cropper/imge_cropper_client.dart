// ignore_for_file: one_member_abstracts

import 'package:image_cropper/image_cropper.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_gpt/app/theme/light/light_theme.dart';
import 'package:scan_gpt/injection.dart';

abstract class ImageCropperClient {
  Future<String?> cropPhoto({required String filePath});
}

@Injectable(as: ImageCropperClient)
class ImageCropperClientImpl implements ImageCropperClient {
  ImageCropperClientImpl({required ImageCropper imageCropper}) : _imageCropper = imageCropper;

  final ImageCropper _imageCropper;
  @override
  Future<String?> cropPhoto({required String filePath}) async {
    final file = await _imageCropper.cropImage(
      sourcePath: filePath,
      compressQuality: 100,
      aspectRatioPresets: _aspectRatioPresets,
      uiSettings: _uiSettings,
    );

    return file?.path;
  }

  final List<CropAspectRatioPreset> _aspectRatioPresets = [
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9,
  ];

  final List<PlatformUiSettings> _uiSettings = [
    AndroidUiSettings(
      toolbarTitle: 'Edit Photo',
      toolbarColor: getIt<LightTheme>().theme.colorScheme.primary,
      toolbarWidgetColor: getIt<LightTheme>().theme.colorScheme.background,
      activeControlsWidgetColor: getIt<LightTheme>().theme.colorScheme.primary,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
      showCropGrid: false,
    ),
    IOSUiSettings(
      title: 'Edit Photo',
    )
  ];
}
