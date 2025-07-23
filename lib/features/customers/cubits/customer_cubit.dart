import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_cubit.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';

class CustomerCubit extends BaseDataTableCubit<UserModel> {
  CustomerCubit(this._repository)
    : super(
        DataTableInitial(),
        CacheStorageManagementImpl<UserModel>(
          FirebaseCollections.users,
          5,
          adapter: UserModelAdapter(),
        ),
      );

  final GenericRepository<UserModel> _repository;

  @override
  bool containSearchQuery(UserModel item, String query) {
    return item.userFullName!.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<Either<String, Unit>> deleteItem(UserModel item) async {
    return await _repository.deleteItem(item);
  }

  @override
  Future<Either<String, List<UserModel>>> fetchItems() async {
    return await _repository.fetchItems();
  }
}
