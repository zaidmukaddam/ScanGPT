import 'package:injectable/injectable.dart';
import 'package:scan_gpt/core/clients/image_picker/image_picker_client.dart';

@injectable
class GalleryLocalDataSource {
  GalleryLocalDataSource({required ImagePickerClient imagePicker}) : _imagePicker = imagePicker;

  final ImagePickerClient _imagePicker;

  Future<String?> selectFromGallery() async {
    final image = await _imagePicker.selectFromGallery();
    return image?.path;
  }
}
