import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/data/models/product/product_variation_model.dart';

class VariationButtonData {
  final ProductType productType;
  final List<ProductVariationModel> variations;

  VariationButtonData({required this.productType, required this.variations});
}
