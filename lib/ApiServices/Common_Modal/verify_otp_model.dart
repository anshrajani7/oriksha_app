class OtpResponse {
  bool success;
  int otp;
  OtpResponseResponse response;

  OtpResponse({required this.success, required this.otp, required this.response});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      success: json['success'],
      otp: json['otp'],
      response: OtpResponseResponse.fromJson(json['response']),
    );
  }
}

class OtpResponseResponse {
  bool returnVal;
  String requestId;
  List<String> message;

  OtpResponseResponse({required this.returnVal, required this.requestId, required this.message});

  factory OtpResponseResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponseResponse(
      returnVal: json['return'],
      requestId: json['request_id'],
      message: List<String>.from(json['message']),
    );
  }
}
