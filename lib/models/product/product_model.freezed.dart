// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  String? get key => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get info => throw _privateConstructorUsedError;
  int? get category1 => throw _privateConstructorUsedError;
  int? get category2 => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  String? get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res>;
  $Res call(
      {String? key,
      String? id,
      String? title,
      String? info,
      int? category1,
      int? category2,
      int? price,
      String? images});
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res> implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  final ProductModel _value;
  // ignore: unused_field
  final $Res Function(ProductModel) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? id = freezed,
    Object? title = freezed,
    Object? info = freezed,
    Object? category1 = freezed,
    Object? category2 = freezed,
    Object? price = freezed,
    Object? images = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
      category1: category1 == freezed
          ? _value.category1
          : category1 // ignore: cast_nullable_to_non_nullable
              as int?,
      category2: category2 == freezed
          ? _value.category2
          : category2 // ignore: cast_nullable_to_non_nullable
              as int?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductModelCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$_ProductModelCopyWith(
          _$_ProductModel value, $Res Function(_$_ProductModel) then) =
      __$$_ProductModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? key,
      String? id,
      String? title,
      String? info,
      int? category1,
      int? category2,
      int? price,
      String? images});
}

/// @nodoc
class __$$_ProductModelCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res>
    implements _$$_ProductModelCopyWith<$Res> {
  __$$_ProductModelCopyWithImpl(
      _$_ProductModel _value, $Res Function(_$_ProductModel) _then)
      : super(_value, (v) => _then(v as _$_ProductModel));

  @override
  _$_ProductModel get _value => super._value as _$_ProductModel;

  @override
  $Res call({
    Object? key = freezed,
    Object? id = freezed,
    Object? title = freezed,
    Object? info = freezed,
    Object? category1 = freezed,
    Object? category2 = freezed,
    Object? price = freezed,
    Object? images = freezed,
  }) {
    return _then(_$_ProductModel(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
      category1: category1 == freezed
          ? _value.category1
          : category1 // ignore: cast_nullable_to_non_nullable
              as int?,
      category2: category2 == freezed
          ? _value.category2
          : category2 // ignore: cast_nullable_to_non_nullable
              as int?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductModel extends _ProductModel {
  _$_ProductModel(
      {required this.key,
      required this.id,
      required this.title,
      required this.info,
      required this.category1,
      required this.category2,
      required this.price,
      required this.images})
      : super._();

  factory _$_ProductModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProductModelFromJson(json);

  @override
  final String? key;
  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? info;
  @override
  final int? category1;
  @override
  final int? category2;
  @override
  final int? price;
  @override
  final String? images;

  @override
  String toString() {
    return 'ProductModel(key: $key, id: $id, title: $title, info: $info, category1: $category1, category2: $category2, price: $price, images: $images)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductModel &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.info, info) &&
            const DeepCollectionEquality().equals(other.category1, category1) &&
            const DeepCollectionEquality().equals(other.category2, category2) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.images, images));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(info),
      const DeepCollectionEquality().hash(category1),
      const DeepCollectionEquality().hash(category2),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(images));

  @JsonKey(ignore: true)
  @override
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      __$$_ProductModelCopyWithImpl<_$_ProductModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductModelToJson(this);
  }
}

abstract class _ProductModel extends ProductModel {
  factory _ProductModel(
      {required final String? key,
      required final String? id,
      required final String? title,
      required final String? info,
      required final int? category1,
      required final int? category2,
      required final int? price,
      required final String? images}) = _$_ProductModel;
  _ProductModel._() : super._();

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$_ProductModel.fromJson;

  @override
  String? get key;
  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get info;
  @override
  int? get category1;
  @override
  int? get category2;
  @override
  int? get price;
  @override
  String? get images;
  @override
  @JsonKey(ignore: true)
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}
