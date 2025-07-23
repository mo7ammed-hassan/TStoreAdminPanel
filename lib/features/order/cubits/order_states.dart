import 'package:equatable/equatable.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

sealed class OrderStates extends Equatable {}

class OrderInitialState extends OrderStates {
  @override
  List<Object?> get props => [];
}

class OrderLoadingState extends OrderStates {
  @override
  List<Object?> get props => [];
}

class OrderLoadedState extends OrderStates {
  final List<OrderModel> orders;
  OrderLoadedState(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderFailureState extends OrderStates {
  final String error;
  OrderFailureState(this.error);
  
  @override
  List<Object?> get props => [error];
}
