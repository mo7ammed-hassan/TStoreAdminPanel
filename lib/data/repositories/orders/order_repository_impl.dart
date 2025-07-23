import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/data/services/orders/order_firebase_services.dart';
import 'package:t_store_admin_panel/domain/repositories/order/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderFirebaseServices _orderFirebaseServices;

  OrderRepositoryImpl(this._orderFirebaseServices);

  @override
  Future<Either<String, Unit>> deleteOrder(String orderId, String userId) async {
    return _orderFirebaseServices.deleteOrder(orderId, userId);
  }

  @override
  Future<Either<String, List<OrderModel>>> fetchOrders() async {
    return _orderFirebaseServices.fetchOrders();
  }

  @override
  Future<Either<String, OrderModel>> fetchSpecificOrder(String orderId) async {
    return _orderFirebaseServices.fetchSpecificOrder(orderId);
  }

  @override
  Future<Either<String, Unit>> updateOrderStatus(OrderModel orderModel) async {
    return _orderFirebaseServices.updateOrderStatus(orderModel);
  }
}
