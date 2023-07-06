// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      key: json['key'] as String?,
      id: json['id'] as String?,
      title: json['title'] as String?,
      info: json['info'] as String?,
      category1: json['category1'] as int?,
      category2: json['category2'] as int?,
      price: json['price'] as int?,
      images: json['images'] as String?,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'id': instance.id,
      'title': instance.title,
      'info': instance.info,
      'category1': instance.category1,
      'category2': instance.category2,
      'price': instance.price,
      'images': instance.images,
    };
