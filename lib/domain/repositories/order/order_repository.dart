import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

abstract class OrderRepository {
  Future<Either<String, List<OrderModel>>> fetchOrders();

  Future<Either<String, OrderModel>> fetchSpecificOrder(String orderId);

  Future<Either<String, Unit>> updateOrderStatus(OrderModel orderModel);

  Future<Either<String, Unit>> deleteOrder(String orderId, String userId);
}
