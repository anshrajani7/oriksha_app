class NetWorkUrl{
  static const String baseUrl = 'https://oriksha.com';

  static const String loginUrl = '$baseUrl/api/login';
  static const String driverRegisterUrl = '$baseUrl/api/drivers/register';
  static const String sendOtpUrl = '$baseUrl/api/send-otp';
  static const String driverLocationUrl = '$baseUrl/api/driver-location';
  static const String bookRideUrl = '$baseUrl/api/book-ride';
  static const String getRideRequestUrl = '$baseUrl/api/receiveRideRequest';
  static const String handelRequestUrl = '$baseUrl/api/handleRideRequest';
  static const String sendRideRequestUrl = '$baseUrl/api/passenger_ConfirmDriver';
  static const String getAllDriverUrl = '$baseUrl/api/get-available-drivers';
  static const String passengerRegisterUrl = '$baseUrl/api/passengers/register';
  static const String updateProfileDriverUrl = '$baseUrl/api/updateDriverProfile';
  static const String updateProfilePassengerUrl = '$baseUrl/api/updatePassengerProfile';
  static const String addAmountUrl = '$baseUrl/api/payment';
  static const String showAmountUrl = '$baseUrl/api/amount_show';
  static const String bankDetailsUrl = '$baseUrl/api/bank_details';
  static const String lockAmountUrl = '$baseUrl/api/lock-amount';
  static const String toggleAmountUrl = '$baseUrl/api/toggleAndAssign';
  static const String redeemAmountUrl = '$baseUrl/api/redeem-amount';
  static const String sendAmountUrl = '$baseUrl/api/sendMoney';
  static const String forgatePinUrl = '$baseUrl/api/forgetPin';
  static const String rideRequestStatusPassengerUrl = '$baseUrl/api/otpVerify_passenger';
  static const String otpVerfiRideUrl = '$baseUrl/api/otpVerify';
  static const String rideComplateUrl = '$baseUrl/api/ride_complete_and_deduct';
  static const String rideHistoryPassangerUrl = '$baseUrl/api/rideHistory_passenger';
  static const String rideHistoryUrl = '$baseUrl/api/rideHistory_driver';
  static const String transationsHistoryUrl = '$baseUrl/api/showTransactions';

}