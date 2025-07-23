import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/widget/media_uploader/build_media_uploader.dart';

/// Media Uploader Section
/// This widget is used to toggle the media uploader section
/// Depends on [MediaActionCubit] if showMediaUploaderSection is true then show the media uploader
class MediaUploaderSection extends StatelessWidget {
  const MediaUploaderSection({super.key, this.showUploderSection = false});
  final bool showUploderSection;

  @override
  Widget build(BuildContext context) {
    return showUploderSection
        ? const BuildMediaUploader()
        : BlocSelector<MediaActionCubit, MediaActionState, bool>(
          selector: (state) {
            return state is ToggleMediaUploaderSection
                ? state.showMediaUploaderSection
                : context.read<MediaActionCubit>().showMediaUploaderSection;
          },
          builder: (context, showUploader) {
            final shouldShow = showUploderSection || showUploader;

            return ClipRect(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                clipBehavior: Clip.antiAlias,
                child:
                    shouldShow
                        ? const BuildMediaUploader()
                        : const SizedBox.shrink(),
              ),
            );
          },
        );
  }
}
