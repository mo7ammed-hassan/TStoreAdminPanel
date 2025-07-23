import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';

abstract class OrderFirebaseServices {
  Future<Either<String, List<OrderModel>>> fetchOrders();

  Future<Either<String, OrderModel>> fetchSpecificOrder(String orderId);

  Future<Either<String, Unit>> updateOrderStatus(OrderModel orderModel);

  //Future<Either<String, Unit>> deleteOrder(String orderId);

  Future<Either<String, Unit>> deleteOrder(String orderId, String userId);
}

class OrderFirebaseServicesImpl implements OrderFirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();

  CollectionReference get _orderRef =>
      _firestore.collection(FirebaseCollections.orders);

  CollectionReference get _usersRef =>
      _firestore.collection(FirebaseCollections.users);

  DocumentReference _orderDocRef(String? id) => _orderRef.doc(id);

  // @override
  // Future<Either<String, Unit>> deleteOrder(String documentId) async {
  //   return _errorHandler.handleErrorEitherAsync(() async {
  //     await _orderDocRef(documentId).delete();
  //     return unit;
  //   });
  // }

  @override
  Future<Either<String, Unit>> deleteOrder(
    String documentId,
    String userId,
  ) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      await _usersRef.doc(userId).collection('Orders').doc(documentId).delete();
      return unit;
    });
  }

  // @override
  // Future<Either<String, List<OrderModel>>> fetchOrders() async {
  //   return _errorHandler.handleErrorEitherAsync(() async {
  //     final queryData =
  //         await _orderRef.orderBy('orderDate', descending: true).get();
  //     return queryData.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
  //   });
  // }

  // @override
  // Future<Either<String, List<OrderModel>>> fetchOrders() async {
  //   return _errorHandler.handleErrorEitherAsync(() async {
  //     final queryData = await _usersRef.get();

  //     final snapshots = await Future.wait(
  //       queryData.docs.map((e) => e.reference.collection('Orders').get()),
  //     );

  //     final allOrders =
  //         snapshots.expand((snapshot) {
  //           return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc));
  //         }).toList();

  //     return allOrders;
  //   });
  // }

  @override
  Future<Either<String, List<OrderModel>>> fetchOrders() async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final queryData = await _usersRef.get();

      final snapshotsWithUsers = await Future.wait(
        queryData.docs.map((userDoc) async {
          final ordersSnapshot =
              await userDoc.reference.collection('Orders').get();
          final userModel = UserModel.fromSnapshot(userDoc);
          return {'user': userModel, 'orders': ordersSnapshot};
        }),
      );

      final allOrders =
          snapshotsWithUsers.expand((entry) {
            final user = entry['user'] as UserModel;
            final orders =
                entry['orders'] as QuerySnapshot<Map<String, dynamic>>;
            return orders.docs.map(
              (orderDoc) =>
                  OrderModel.fromSnapshot(orderDoc).copyWith(userData: user),
            );
          }).toList();

      return allOrders;
    });
  }

  @override
  Future<Either<String, OrderModel>> fetchSpecificOrder(String orderId) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final queryData = await _orderDocRef(orderId).get();
      return OrderModel.fromSnapshot(queryData);
    });
  }

  @override
  Future<Either<String, Unit>> updateOrderStatus(OrderModel orderModel) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      await _orderDocRef(
        orderModel.docId,
      ).update({'status': orderModel.orderStatus});
      return unit;
    });
  }
}
