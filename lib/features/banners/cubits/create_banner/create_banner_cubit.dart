import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/app_screens.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/helpers/media_picker_helper.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/features/banners/cubits/create_banner/create_banner_states.dart';

class CreateBannerCubit extends Cubit<CreateBannerStates> {
  CreateBannerCubit(this._repository) : super(CreateBannerInitialState());

  final GenericRepository<BannerModel> _repository;

  String? imageUrl = '';
  bool active = false;
  String targetScreen = AppScreens.allAppScreens[0];

  Future<void> createBanner() async {
    emit(CreateBannerLoadingState());
    if (imageUrl == null || imageUrl!.isEmpty) {
      Loaders.warningSnackBar(
        title: 'Error',
        message: 'Please select an image',
      );
      return;
    }

    CustomDialogs.showCircularLoader();

    final newBanner = BannerModel(
      id: '',
      image: imageUrl,
      active: active,
      targetScreen: targetScreen,
    );

    final result = await _repository.createItem(newBanner);

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to create banner: ${error.toString()}',
        );
        emit(CreateBannerFailureState(errorMessage: error.toString()));
      },
      (bannerId) async {
        newBanner.id = bannerId;

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Banner created successfully',
        );
        emit(CreateBannerSuccessState(banner: newBanner));
      },
    );
  }

  void toggleActive(bool value) {
    active = value;
    emit(ToggleActiveState(active: active));
  }

  Future<void> pickImage() async {
    imageUrl = await MediaPickerHelper.pickAndUpdateImage<PickImageState>(
      imageUrl,
      (selectedImage) => emit(PickImageState(selectedImage ?? '')),
    );
  }

  void setTargetScreen(String screen) {
    targetScreen = screen;
    emit(TargetScreenState(targetScreen: targetScreen));
  }

  void resetForm() {
    imageUrl = null;
    active = false;
    targetScreen = AppScreens.allAppScreens[0];
    emit(CreateBannerInitialState());
  }
}
