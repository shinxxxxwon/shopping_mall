
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel{
  factory ProductModel({
    required String? id,
    required String? title,
    required String? info,
    required int? category1,
    required int? category2,
    required String? price,
    required String? images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  ProductModel._();
}