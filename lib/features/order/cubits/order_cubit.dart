import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_cubit.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/domain/repositories/order/order_repository.dart';

class OrderCubit extends BaseDataTableCubit<OrderModel> {
  OrderCubit(this._orderRepository)
    : super(
        DataTableInitial(),
        CacheStorageManagementImpl<OrderModel>(
          FirebaseCollections.orders,
          4,
          adapter: OrderModelAdapter(),
        ),
      );

  final OrderRepository _orderRepository;

  @override
  bool containSearchQuery(OrderModel item, String query) {
    return item.orderStatus!.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<Either<String, Unit>> deleteItem(OrderModel item) async {
    return await _orderRepository.deleteOrder(item.docId!, item.userId!);
  }

  @override
  Future<Either<String, List<OrderModel>>> fetchItems() async {
    return await _orderRepository.fetchOrders();
  }
}
