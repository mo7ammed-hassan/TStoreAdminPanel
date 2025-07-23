
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class MediaPickerHelper {
  const MediaPickerHelper._(); // Constructor private لمنع الإنشاء

  static Future<String> pickAndUpdateImage<State>(
    String? currentImageUrl,
    Function(String?) emitNewState,
  ) async {
    final mediaCubit = getIt<MediaCubit>();
    final selectedImages = await mediaCubit.selectionImagesFromMedia();
    final newImageUrl = selectedImages?.firstOrNull?.url;

    if (newImageUrl != null && newImageUrl != currentImageUrl) {
      emitNewState(newImageUrl);
    }

    return newImageUrl ?? currentImageUrl ?? '';
  }

  static Future<List<String>> pickAndUpdateImages<State>(
    List<String>? currentImagesUrl,
    Function(List<String>?) emitNewState,
  ) async {
    final mediaCubit = getIt<MediaCubit>();
    final selectedImages = await mediaCubit.selectionImagesFromMedia();
    final newImagesUrl = selectedImages ?.map((image) => image.url).toList();

    if (newImagesUrl != null && newImagesUrl != currentImagesUrl && newImagesUrl.isNotEmpty) {
      emitNewState(newImagesUrl);
    }

    return newImagesUrl ?? currentImagesUrl ?? <String>[];
  }
}