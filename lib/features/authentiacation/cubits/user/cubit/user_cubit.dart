import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/extensions/sidebar_extension.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/domain/repositories/user/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepo) : super(UserInitial()) {
    fetchUserDetails();
  }

  final UserRepo _userRepo;
  UserModel userData = UserModel(userEmail: '');

  Future<void> fetchUserDetails() async {
    emit(UserLoadingState());

    var result = await _userRepo.fetchUserDetails();
    result.fold((error) => emit(UserErrorState(error)), (user) {
      userData = user;
      emit(UserLoadedState(user));
    });
  }

  // Method for showing dialog for logout
  Future<void> logoutOnConfirmation() async {
    final result = await CustomDialogs.showConfirmationDialog(
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmButtonText: 'Logout',
      cancelButtonText: 'Cancel',
    );

    if (result) {
      await signOut();
    }
  }

  // 🔄 Reset UserCubit state
  Future<void> signOut() async {
    CustomDialogs.showCircularLoader();

    var result = await _userRepo.signOut();
    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to logout.\n$error',
        );
        emit(UserErrorState(error));
      },
      (_) {
        CustomDialogs.hideLoader();
        emit(UserInitial());
        // Start New Session
        AppContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          SidebarRoutes.logout.path,
          (route) => false,
        );
      },
    );
  }
}
