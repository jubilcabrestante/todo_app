import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final bool isSuccess;
  final String? errorMesage;
  final int? statusCode;
  final dynamic data;

  const Failure({
    required this.isSuccess,
    this.errorMesage,
    this.statusCode,
    this.data,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isSuccess, errorMesage, statusCode];
}

// external error
class ApiFailure extends Failure {
  const ApiFailure({
    super.isSuccess = false,
    super.errorMesage = "Something went wrong. Please try again later.",
    super.data,
  });
}
