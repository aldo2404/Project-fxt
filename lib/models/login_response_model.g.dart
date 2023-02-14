part of 'login_response_model.dart';

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      token: json['token'] as String?,
      error: json['error'] as String?,
      //  domain: json['domains'] as String?
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'error': instance.error,
      //'domain': instance.domain,
    };
