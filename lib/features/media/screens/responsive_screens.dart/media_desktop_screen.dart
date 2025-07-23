import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/widget/media_content/media_content_section.dart';
import 'package:t_store_admin_panel/features/media/widget/media_screen_header.dart';
import 'package:t_store_admin_panel/features/media/widget/media_uploader/media_uploader_section.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Media Screen Header
              MediaScreenHeader(),
              SizedBox(height: AppSizes.spaceBtwSections),

              /// Media Uploader Section
              MediaUploaderSection(),
              SizedBox(height: AppSizes.spaceBtwItems),

              /// Media Content Section // allow multi selection and selection false
              MediaContentSection(),
              SizedBox(height: AppSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
