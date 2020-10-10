import 'package:flutter_app/core/services/api_for_table_orders.dart';
import 'package:flutter_app/core/services/api_for_table_products.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableOrders.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableProducts.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => ApiForTableProducts('products'));
  locator.registerLazySingleton(() => ApiForTableOrders('orders'));
  locator.registerLazySingleton(() => CRUDModelForTableOrders()) ;
  locator.registerLazySingleton(() => CRUDModelForTableProducts()) ;
}