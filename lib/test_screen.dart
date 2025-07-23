import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class UserModel extends Equatable {
  final String username;
  final String email;
  final String profilePic;

  const UserModel({
    required this.username,
    required this.email,
    required this.profilePic,
  });

  UserModel copyWith({String? username, String? email, String? profilePic}) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  @override
  List<Object?> get props => [username, email, profilePic];
}

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final UserModel user;
  const UserLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUpdatedState extends UserState {
  final UserModel updatedUser;
  const UserUpdatedState(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class UserErrorState extends UserState {
  final String error;
  const UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  late UserModel _currentUser;

  Future<void> fetchUser() async {
    _currentUser = const UserModel(
      username: "Mohamed",
      email: "mohamed@example.com",
      profilePic: AppImages.darkAppLogo,
    );
    emit(UserLoadedState(_currentUser));
  }

  Future<void> updateUsername(String newUsername) async {
    if (_currentUser.username != newUsername) {
      _currentUser = _currentUser.copyWith(username: newUsername);
      emit(UserUpdatedState(_currentUser));
    }
  }

  Future<void> updateProfilePic(String newPic) async {
    if (_currentUser.profilePic != newPic) {
      _currentUser = _currentUser.copyWith(profilePic: newPic);
      emit(UserUpdatedState(_currentUser));
    }
  }

  // reset user data
  void resetUser() {
    _currentUser = const UserModel(
      username: "Mohamed",
      email: "mohamed@example.com",
      profilePic: AppImages.darkAppLogo,
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(title: const Text("User Profile")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (context) {
              return Center(
                child: Column(
                  spacing: AppSizes.spaceBtwItems,
                  children: [
                    /// ✅ الصورة تتغير فقط عند تحديث `profilePic`
                    BlocSelector<UserCubit, UserState, String>(
                      selector: (state) {
                        if (state is UserLoadedState) {
                          return state.user.profilePic;
                        }
                        if (state is UserUpdatedState) {
                          return state.updatedUser.profilePic;
                        }
                        return AppImages.darkAppLogo;
                      },
                      builder: (context, profilePic) {
                        debugPrint("🔄 تحديث الصورة");
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(profilePic),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    /// ✅ الاسم يتغير فقط عند تحديث `username`
                    BlocSelector<UserCubit, UserState, String>(
                      selector: (state) {
                        if (state is UserLoadedState) {
                          return state.user.username;
                        }
                        if (state is UserUpdatedState) {
                          return state.updatedUser.username;
                        }
                        return "No Name";
                      },
                      builder: (context, username) {
                        debugPrint("🔄 تحديث الاسم");
                        return Text(
                          "👤 الاسم: $username",
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 18),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    /// ✅ البريد الإلكتروني لا يتغير أبدًا لأنه ثابت
                    BlocSelector<UserCubit, UserState, String>(
                      selector: (state) {
                        if (state is UserLoadedState) return state.user.email;
                        return "No Email";
                      },
                      builder: (context, email) {
                        debugPrint("🔄 تحديث البريد الإلكتروني");
                        return Text(
                          "📧 البريد: $email",
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 18),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    /// 🔘 زر تحديث الاسم فقط
                    SizedBox(
                      width: AppSizes.buttonWidth * 1.5,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserCubit>().updateUsername("Omar");
                          //context.read<UserCubit>().resetUser();
                        },
                        child: const Text("تحديث الاسم"),
                      ),
                    ),

                    /// 🔘 زر تحديث الصورة فقط
                    SizedBox(
                      width: AppSizes.buttonWidth * 1.5,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserCubit>().updateProfilePic(
                            AppImages.lightAppLogo,
                          );
                        },
                        child: const Text("تحديث الصورة"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
/*

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    this.onTapAddImages,
    required this.additionalProductImagesUrls,
    this.onTapRemoveImage,
  });

  final Function()? onTapAddImages;
  final List<String> additionalProductImagesUrls;
  final void Function(int index)? onTapRemoveImage;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final hasImages = additionalProductImagesUrls.isNotEmpty;

    return SizedBox(
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main image upload area
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTapAddImages,
              behavior: HitTestBehavior.opaque,
              child: _buildMainUploadArea(),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Thumbnail list and add button
          SizedBox(
            height: 80,
            child: Row(
              children: [
                // Images list
                Expanded(
                  flex: 2,
                  child:
                      hasImages
                          ? _buildImageThumbnails()
                          : _buildPlaceholderThumbnails(isDark),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),

                // Add button
                _buildAddButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainUploadArea() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.defaultImages, width: 80, height: 80),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const Text('Add Additional Product Images'),
        ],
      ),
    );
  }

  Widget _buildImageThumbnails() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImagesUrls.length,
      separatorBuilder:
          (_, __) => const SizedBox(width: AppSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        return _buildThumbnailItem(index);
      },
    );
  }

  Widget _buildThumbnailItem(int index) {
    return UploaderImage<CreateProductCubit, CreateProductStates>(
      width: 80,
      height: 80,
      top: 0,
      right: 0,
      left: null,
      bottom: null,
      imageSelector: (state) => additionalProductImagesUrls[index],
      icon: Iconsax.trash,
      onImageChanged: () => onTapRemoveImage!(index),
    );
  }

  Widget _buildPlaceholderThumbnails(bool isDark) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder:
          (_, __) => const SizedBox(width: AppSizes.spaceBtwItems / 2),
      itemBuilder:
          (_, __) => RoundedContainer(
            width: 80,
            height: 80,
            backgroundColor:
                isDark ? AppColors.darkGrey : AppColors.primaryBackground,
          ),
    );
  }

  Widget _buildAddButton() {
    return RoundedContainer(
      height: 80,
      width: 80,
      showBorder: true,
      borderColor: AppColors.grey,
      onTap: onTapAddImages,
      child: const Center(child: Icon(Iconsax.add)),
    );
  }
}








 */