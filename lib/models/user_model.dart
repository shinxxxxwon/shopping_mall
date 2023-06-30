
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel{

  factory UserModel({
    required String? id,
    required String? password,
    required String? name,
    required String? phone,
    required String? address,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // 메소드나 custom getter 작성시 필수로 추가
  UserModel._();
}