import 'package:oriksha_application/core/app_export.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_GB": enGB,
    "hi": hi,
    "mr": mr
  };
}

final Map<String, String> enGB = {
  'title': 'Hello, How are you?',
  'day': "Awesome day...",
  AppString.selectLanguage: "SELECT LANGUAGE",
  AppString.marathi: "MARATHI",
  AppString.hindi: "HINDI",
  AppString.english: "ENGLISH",
  AppString.continu: "CONTINUE",
  AppString.forNewUser: "FOR NEW USER",
  AppString.register: "REGISTER",
  AppString.pleaseEnterYourMobileNumberToContinue:
      "Please enter your mobile number to continue",
  AppString.mobileNumber: "Mobile Number",
  AppString.forgetPin: "Forget Pin",
  AppString.logIN: "LOGIN",
  AppString.driver: "Driver",
  AppString.cancel: "Cancel",
  AppString.passenger: "PASSENGER",
  AppString.iAm: "I AM",
  AppString.next: "Next",
  AppString.vehicleDetails: "VEHICLE DETAILS",
  AppString.vehicleNumber: "VEHICLE Number",
  AppString.licenceNumber: "Licence Number",
  AppString.DriverPhoto: "Driver Photo",
  AppString.vehiclePhotoFront: "Vehicle Photo(Front)",
  AppString.vehiclePhotoBack: "Vehicle Photo(Back)",
  AppString.chooseFile: "Choose File",
  AppString.browseFile: "Browse File",
  AppString.driverName: "Driver Name",
  AppString.emailId: "Email Id",
  AppString.pin: 'PIN',
  AppString.confirmPIN: 'Confirm PIN',
  AppString.adharNumber: "Adhar Number",
  AppString.adharPhotofront: "Adhar Photo(Front)",
  AppString.submit: "SUBMIT",
  AppString.driverDetails: "DRIVER DETAILS",
  AppString.uploadPhoto: "Upload photo",
  AppString.uploadThePhotoAndWeWilll:
      "Upload the photo and we will do the rest",
  AppString.camera: "Camera",
  AppString.gallery: "Gallery",
  AppString.driverPhoto: "Driver Photo",
  AppString.driversmall: "driver",
  AppString.customerDetails: "Customer Details",
  AppString.enterPickUpPoint: "Enter Pick Up Point",
  AppString.update: "UPDATE",
  AppString.yourPinCode: "Your Pincode",
  AppString.detailsAdress: "Detail Address (Gift Purpose)",
  AppString.profilePicture: "Profile Picture",
  AppString.fullName: "Full Name",
  AppString.anshRajani: "Ansh Rajani",
  AppString.setting: "Setting",
  AppString.legal: "Legal",
  AppString.feedBack: "Feedback",
  AppString.fiveZeroZero: "500",
  AppString.myavailableBalance: "MY AVAILABLE BALANCE",
  AppString.transaction: "Transaction",
  AppString.transactiondetails: "Transactions Details",
  AppString.adhaZero: "80",
  AppString.congratulationsYouHave:
      'Congratulations! You have received welcome COINS',
  AppString.myBankDetailsQRCode: 'My Bank Details & QR Code',
  AppString.termConditions: 'Term & Conditions',
  AppString.myRewardsAndGifts: "My Rewards And Gifts",
  AppString.rideHistory: "Ride History",
  AppString.companysDocument: "Company\'s Document",
  AppString.logOut: "Logout",
  AppString.bankAccountNumber: 'Bank Account Number',
  AppString.iFSCCode: 'IFSC Code',
  AppString.bankAccountHoldersName: 'Bank Account Holder\'s Name',
  AppString.qRCodePhoto: 'QR Code Photo',
  AppString.error: "Error",
  AppString.confirm: "Confirm",
  AppString.pleaseEnterVehicleNumber: 'Please Enter Vehicle Number',
  AppString.pleaseEnterValidVehicleNumber: 'Please Enter Valid Vehicle Number',
  AppString.pleaseEnterLicenceNumber: 'Please Enter Licence Number',
  AppString.pleaseEnterValidLicenceNumber: 'Please Enter Valid Licence Number',
  AppString.pleasePickDriverPhoto: 'Please Enter Licence Number',
  AppString.pleasePickVehiclePhotoFront: 'Please Pick Vehicle Photo(Front)',
  AppString.pleasePickVehiclePhotoBack: 'Please Pick Vehicle Photo(Back)',
  AppString.pleaseEnterName: 'Please Full Enter Name',
  AppString.pleaseMobileNumber: 'Please Enter Mobile Number',
  AppString.pleaseEnterValidMobileNumber: 'Please Enter Valid Mobile Number',
  AppString.pleaseEnterEmailId: 'Please Enter Email Id',
  AppString.pleaseEnterPin: "Please Enter Pin",
  AppString.pleaseEnterConfirmPin: "Please Confirm Enter Pin",
  AppString.pleaseEnterAdharNumber: 'Please Enter Adhar Number',
  AppString.pleaseEnterValidAdharNumber: 'Please Enter Valid Adhar Number',
  AppString.pleasePickAdharPhotofront: 'Please Pick Adhar Photo(Front)',
  AppString.pleasePickAdharPhotoBack: 'Please Pick Adhar Photo(Back)',
  AppString.referralCode: 'Referral Code',
  AppString.iAgreeToTheTermAndCondition: "I Agree To The Term and Condition",
  AppString.verifyOtp: "Verify OTP",
  AppString.recharge: 'Recharge',
  AppString.withdraw: 'Withdraw',
  AppString.sendRupees: 'Send Rupees',
  AppString.lockAmount: 'Lock Amount',
  AppString.myAvailableBalance: "MY AVAILABLE BALANCE",

  //vnjdnvdv
  AppString.aMessageWithAVerification:
      "A Message with a Verification code was send to Mobile Number :",
  AppString.pinOrConfirmPinNotMatch: "PIN OR CONFIRM PIN NOT MATCH",
  AppString.pleaseCheckATermsAndCondition: "Please Check a terms and condition",
  AppString.confirmRide: "Confirm Ride",
  AppString.totalMoney: "Total Money :",
  AppString.totalDuration: "Total Duration :",
  AppString.totalDistance: "Total Distance :",
  AppString.dashboard: "DASHBOARD",
  AppString.accept: "ACCEPT",
  AppString.reject: "REJECT",
  AppString.pleaseSelectAAadhaarImageFront:
      "Please Select a Aadhaar Image(Front)!",
  AppString.enterYourFeedBack: 'Enter your feedback',
  AppString.postYourReview: "POST YOUR REVIEW",
  AppString.pickupLocation: "Pickup Location",
  AppString.dropLocation: "Drop Location",
  AppString.setMap: "Set Map",
  AppString.theFeedbackIGave: 'The Feedback I Gave',
  AppString.theFeedbackIReceived: 'The Feedback I Received',
  AppString.pleaseEnterOtp: "Please Enter Otp!",
  AppString.pleaseValidEnterOtp: "Please Enter Valid Otp !",
  AppString.copyRight: "Copyright",
  AppString.termsConditions: "Terms & Conditions",
  AppString.privacyPolicy: "Privacy Policy",
  AppString.dataProviders: "Data Providers",
  AppString.softwareLincences: "Software Lincences",
  AppString.locationInformation: "Location Information",
  AppString.cityRegulations: "City Regulations",
  AppString.edit: "Edit",
  AppString.sOS: "SOS",
  AppString.enterAPickupPoint: "Enter a Pickup Point",
  AppString.youSavedUpToOnYourAutoRide:
      "You've saved upto \$3 on your Auto Ride!",
  AppString.auto: "Auto",
  AppString.rideNow: "RIDE NOW",
  AppString.couponApplied: "Coupon applied",
  AppString.cash: "Cash",
  AppString.youCanPayViaOrUpi: "You can pay via cash or upi for your ride",
  AppString.bookRide: "Book Ride",
  AppString.dashBoard: "DASHBOARD",
  AppString.withCompanyLogo: "with Company Logo",
  AppString.close: "Close",
  AppString.yourTransactionIsSuccessfully:
      "Your Transaction is Successfully Completed",
  AppString.firstRideBonus: "First Ride Bonus",
  AppString.welcomeBonus: "Welcome Bonus",
  AppString.sharingAppBonus: "Sharing App Bonus",
  AppString.rideCompleted: "Ride Completed",
  AppString.receivedFromFriend: "Received From Friend",
};

final Map<String, String> hi = {
  'title': 'नमस्ते आप कैसे हैं?',
  'day': "शानदार दिन...",
  AppString.selectLanguage: "भाषा चुने",
  AppString.marathi: "मराठी",
  AppString.hindi: "हिंदी",
  AppString.english: "अंग्रेज़ी",
  AppString.continu: "जारी रखें",
  AppString.forNewUser: "नए उपयोगकर्ता के लिए",
  AppString.register: "पंजीकरण करवाना",
  AppString.transactiondetails: "लेन-देन विवरण",
  AppString.pleaseEnterYourMobileNumberToContinue:
      "जारी रखने के लिए कृपया अपना मोबाइल नंबर दर्ज करें",
  AppString.mobileNumber: "मोबाइल नंबर",
  AppString.forgetPin: "पिन भूल जाओ",
  AppString.logIN: "लॉग इन करें",
  AppString.driver: "चालक",
  AppString.cancel: "रद्द करना",
  AppString.passenger: "यात्री",
  AppString.iAm: "मैं हूँ",
  AppString.next: "अगला",
  AppString.vehicleDetails: "वाहन की सूचना",
  AppString.vehicleNumber: "गाडी नंबर",
  AppString.licenceNumber: "अधिकार पत्र संख्या",
  AppString.DriverPhoto: "ड्राइवर फोटो",
  AppString.vehiclePhotoFront: "वाहन फोटो(सामने)",
  AppString.vehiclePhotoBack: "वाहन फोटो(पीछे)",
  AppString.chooseFile: "फाइलें चुनें",
  AppString.browseFile: "फाइल खोजो",
  AppString.driverName: "चालक का नाम",
  AppString.emailId: "ईमेल आईडी",
  AppString.pin: 'नत्थी करना',
  AppString.confirmPIN: 'पिन की पुष्टि करें',
  AppString.adharNumber: "आधार नंबर",
  AppString.adharPhotofront: "आधार फोटो(सामने)",
  AppString.submit: "जमा करना",
  AppString.driverDetails: "ड्राइवर का विवरण",
  AppString.uploadPhoto: "फोटो अपलोड करें",
  AppString.uploadThePhotoAndWeWilll: "फोटो अपलोड करें और हम बाकी काम करेंगे",
  AppString.camera: "कैमरा",
  AppString.gallery: "गैलरी",
  AppString.driverPhoto: "ड्राइवर फोटो",
  AppString.driversmall: "ड्राइवर",
  AppString.customerDetails: "ग्राहक विवरण",
  AppString.enterPickUpPoint: "पिक अप प्वाइंट दर्ज करें",
  AppString.update: "अद्यतन",
  AppString.yourPinCode: "आपका पिनकोड",
  AppString.detailsAdress: "विस्तृत पता (उपहार प्रयोजन)",
  AppString.profilePicture: "प्रोफ़ाइल फोटो",
  AppString.fullName: "पूरा नाम",
  AppString.anshRajani: "अंश रजनी",
  AppString.setting: "सेटिंग",
  AppString.legal: "कानूनी",
  AppString.feedBack: "प्रतिक्रिया",
  AppString.fiveZeroZero: "पाँच सौ",
  AppString.myavailableBalance: "मेरा उपलब्ध शेष",
  AppString.transaction: "लेन-देन",
  AppString.adhaZero: "अस्सी",
  AppString.congratulationsYouHave:
      'बधाई हो! आपको स्वागत सिक्के प्राप्त हुए हैं',
  AppString.myBankDetailsQRCode: 'मेरा बैंक विवरण और क्यूआर कोड',
  AppString.termConditions: 'नियम & शर्तें',
  AppString.myRewardsAndGifts: "मेरे पुरस्कार और उपहार",
  AppString.rideHistory: "सवारी का इतिहास",
  AppString.companysDocument: "कंपनी का दस्तावेज़",
  AppString.logOut: "लॉग आउट",
  AppString.bankAccountNumber: 'बैंक खाता संख्या',
  AppString.iFSCCode: 'आईएफएससी कोड',
  AppString.bankAccountHoldersName: 'बैंक खाताधारक का नाम',
  AppString.qRCodePhoto: 'क्यूआर कोड फोटो',
  AppString.error: "गलती",
  AppString.confirm: "पुष्टि करना",
  AppString.pleaseEnterVehicleNumber: 'कृपया वाहन संख्या दर्ज करें',
  AppString.pleaseEnterValidVehicleNumber: 'कृपया वैध वाहन नंबर दर्ज करें',
  AppString.pleaseEnterLicenceNumber: 'कृपया लाइसेंस नंबर दर्ज करें',
  AppString.pleaseEnterValidLicenceNumber: 'कृपया वैध लाइसेंस नंबर दर्ज करें',
  AppString.pleasePickDriverPhoto: 'कृपया लाइसेंस नंबर दर्ज करें',
  AppString.pleasePickVehiclePhotoFront: 'कृपया वाहन चुनें फोटो (सामने)',
  AppString.pleasePickVehiclePhotoBack: 'कृपया वाहन चुनें फोटो(पीछे)',
  AppString.pleaseEnterName: 'कृपया पूरा नाम दर्ज करें',
  AppString.pleaseMobileNumber: 'कृपया मोबाइल नंबर दर्ज करें',
  AppString.pleaseEnterValidMobileNumber: 'कृपया वैध मोबाइल नंबर दर्ज करें',
  AppString.pleaseEnterEmailId: 'कृपया ईमेल आईडी दर्ज करें',
  AppString.pleaseEnterPin: "कृपया पिन दर्ज करें",
  AppString.pleaseEnterConfirmPin: "कृपया पिन दर्ज करने की पुष्टि करें",
  AppString.pleaseEnterAdharNumber: 'कृपया आधार नंबर दर्ज करें',
  AppString.pleaseEnterValidAdharNumber: 'कृपया वैध आधार नंबर दर्ज करें',
  AppString.pleasePickAdharPhotofront: 'कृपया आधार फोटो (सामने) चुनें',
  AppString.pleasePickAdharPhotoBack: 'कृपया आधार फोटो चुनें (पीछे)',
  AppString.referralCode: 'रेफरल कोड',
  AppString.iAgreeToTheTermAndCondition: "मैं नियम एवं शर्त से सहमत हूं",
  AppString.verifyOtp: "ओटीपी सत्यापित करें",
  AppString.recharge: 'फिर से दाम लगाना',
  AppString.withdraw: 'निकालना',
  AppString.sendRupees: 'रुपये भेजो',
  AppString.lockAmount: 'लॉक राशि',
  AppString.myAvailableBalance: "मेरा उपलब्ध शेष",
  AppString.aMessageWithAVerification:
      "सत्यापन कोड वाला एक संदेश मोबाइल नंबर पर भेजा गया था:",
  AppString.pinOrConfirmPinNotMatch: "पिन या पुष्टि करें कि पिन मेल नहीं खाता",
  AppString.pleaseCheckATermsAndCondition: "कृपया एक नियम और शर्त की जाँच करें",
  AppString.confirmRide: "सवारी की पुष्टि करें",
  AppString.totalMoney: "संपूर्ण धन :",
  AppString.totalDuration: "कुल अवधि :",
  AppString.totalDistance: "कुल दूरी :",
  AppString.dashboard: "डैशबोर्ड",
  AppString.accept: "स्वीकार करना",
  AppString.reject: "अस्वीकार करना",
  AppString.pleaseSelectAAadhaarImageFront: "कृपया आधार छवि (सामने) चुनें!",
  AppString.enterYourFeedBack: 'अपनी प्रतिक्रिया दर्ज करें',
  AppString.postYourReview: "अपनी समीक्षा पोस्ट करें",
  AppString.pickupLocation: "लेने की जगह",
  AppString.dropLocation: "ड्रॉप स्थान",
  AppString.setMap: "मानचित्र सेट करें",
  AppString.theFeedbackIGave: 'मैंने जो फीडबैक दिया',
  AppString.theFeedbackIReceived: 'मुझे जो फीडबैक मिला',
  AppString.pleaseEnterOtp: "कृपया ओटीपी दर्ज करें!",
  AppString.pleaseValidEnterOtp: "कृपया वैध ओटीपी दर्ज करें!",
  AppString.copyRight: "कॉपीराइट",
  AppString.termsConditions: "नियम एवं शर्तें",
  AppString.privacyPolicy: "गोपनीयता नीति",
  AppString.dataProviders: "डेटा प्रदाता",
  AppString.softwareLincences: "सॉफ्टवेयर लाइसेंस",
  AppString.locationInformation: "स्थिति सूचना",
  AppString.cityRegulations: "शहर के नियम",
  AppString.edit: "संपादन करना",
  AppString.sOS: "मुसीबत का इशारा",
  AppString.enterAPickupPoint: "एक पिकअप प्वाइंट दर्ज करें",
  AppString.youSavedUpToOnYourAutoRide:
      "आपने अपनी ऑटो राइड पर \$3 तक की बचत की है!",
  AppString.auto: "ऑटो",
  AppString.rideNow: "अभी चलो",
  AppString.couponApplied: "कूपन लागू किया गया",
  AppString.cash: "नकद",
  AppString.youCanPayViaOrUpi:
      "आप अपनी सवारी के लिए नकद या upi के माध्यम से भुगतान कर सकते हैं",
  AppString.bookRide: "पुस्तक की सवारी",
  AppString.dashBoard: "डैशबोर्ड",
  AppString.withCompanyLogo: "कंपनी के लोगो के साथ",
  AppString.close: "बंद करना",
  AppString.yourTransactionIsSuccessfully:
      "आपका लेनदेन सफलतापूर्वक पूरा हो गया है",
  AppString.firstRideBonus: "पहली सवारी बोनस",
  AppString.welcomeBonus: "स्वागत बोनस",
  AppString.sharingAppBonus: "शेयरिंग ऐप बोनस",
  AppString.rideCompleted: "सवारी पूरी हुई",
  AppString.receivedFromFriend: "मित्र से प्राप्त हुआ",
};

final Map<String, String> mr = {
  'title': "हॅलो, कसे आहात",
  'day': "अप्रतिम दिवस ...",
  AppString.selectLanguage: "भाषा निवडा",
  AppString.marathi: "हिंदी",
  AppString.english: "इंग्रजी",
  AppString.continu: "सुरू",
  AppString.forNewUser: "नवीन वापरकर्त्यासाठी",
  AppString.register: "नोंदणी करा",
  AppString.pleaseEnterYourMobileNumberToContinue:
      "सुरू ठेवण्यासाठी कृपया तुमचा मोबाइल नंबर एंटर करा",
  AppString.transactiondetails: "व्यवहार तपशील",

  AppString.mobileNumber: "मोबाईल नंबर",
  AppString.forgetPin: "पिन विसरा",
  AppString.logIN: "लॉगिन करा",
  AppString.driver: "चालक",
  AppString.cancel: "रद्द करा",
  AppString.passenger: "प्रवासी",
  AppString.iAm: "मी आहे",
  AppString.next: "पुढे",
  AppString.vehicleDetails: "वाहन तपशील",
  AppString.vehicleNumber: "वाहन क्रमांक",
  AppString.licenceNumber: "परवाना क्रमांक",
  AppString.DriverPhoto: "ड्रायव्हर फोटो",
  AppString.vehiclePhotoFront: "वाहनाचा फोटो (समोरचा)",
  AppString.vehiclePhotoBack: "वाहनाचा फोटो (मागे)",
  AppString.chooseFile: "फाईल निवडा",
  AppString.browseFile: "फाइल ब्राउझ करा",
  AppString.driverName: "चालकाचे नाव",
  AppString.emailId: "ई - मेल आयडी",
  AppString.pin: 'पिन',
  AppString.confirmPIN: 'पिनची पुष्टी करा',
  AppString.adharNumber: "आधार क्रमांक",
  AppString.adharPhotofront: "आधार फोटो(समोर)",
  AppString.submit: "प्रस्तुत करणे",
  AppString.driverDetails: "ड्रायव्हर तपशील",
  AppString.uploadPhoto: "फोटो अपलोड करें",
  AppString.uploadThePhotoAndWeWilll: "फोटो अपलोड करा बाकीचे काम आम्ही करू",
  AppString.camera: "कॅमेरा",
  AppString.gallery: "गॅलरी",
  AppString.driverPhoto: "ड्रायव्हर फोटो",
  AppString.driversmall: "चालक",
  AppString.customerDetails: "ग्राहक तपशील",
  AppString.enterPickUpPoint: "पिक अप पॉइंट एंटर करा",
  AppString.update: "अपडेट करा",
  AppString.yourPinCode: "तुमचा पिनकोड",
  AppString.detailsAdress: "तपशीलवार पत्ता (भेट उद्देश)",
  AppString.profilePicture: "परिचय चित्र",
  AppString.fullName: "पूर्ण नाव",
  AppString.anshRajani: "अंश रजनी",
  AppString.setting: "सेटिंग",
  AppString.legal: "कायदेशीर",
  AppString.feedBack: "फीडबॅक",
  AppString.fiveZeroZero: "५००",
  AppString.myavailableBalance: "माझी उपलब्ध शिल्लक",
  AppString.transaction: "व्यवहार",
  AppString.adhaZero: "80",
  AppString.congratulationsYouHave: 'अभिनंदन! तुम्हाला स्वागत कॉइन मिळाले आहेत',
  AppString.myBankDetailsQRCode: 'माझ्या बँकेचे तपशील आणि QR कोड',
  AppString.termConditions: 'मुदत आणि अटी',
  AppString.myRewardsAndGifts: "माझे बक्षिसे आणि भेटवस्तू",
  AppString.rideHistory: "राइड इतिहास",
  AppString.companysDocument: "कंपनीचे दस्तऐवज",
  AppString.logOut: "बाहेर पडणे",
  AppString.bankAccountNumber: 'बँक खाते क्रमांक',
  AppString.iFSCCode: 'IFSC कोड',
  AppString.bankAccountHoldersName: 'बँक खातेधारकाचे नाव',
  AppString.qRCodePhoto: 'QR कोड फोटो',
  AppString.error: "त्रुटी",
  AppString.confirm: "पुष्टी",
  AppString.pleaseEnterVehicleNumber: 'कृपया वाहन क्रमांक प्रविष्ट करा',
  AppString.pleaseEnterValidVehicleNumber:
      'कृपया वैध वाहन क्रमांक प्रविष्ट करा',
  AppString.pleaseEnterLicenceNumber: 'कृपया परवाना क्रमांक प्रविष्ट करा',
  AppString.pleaseEnterValidLicenceNumber:
      'कृपया वैध परवाना क्रमांक प्रविष्ट करा',
  AppString.pleasePickDriverPhoto: 'कृपया परवाना क्रमांक प्रविष्ट करा',
  AppString.pleasePickVehiclePhotoFront: 'कृपया वाहनाचा फोटो निवडा (समोरचा)',
  AppString.pleasePickVehiclePhotoBack: 'कृपया वाहनाचा फोटो निवडा (मागे)',
  AppString.pleaseEnterName: 'कृपया पूर्ण नाव प्रविष्ट करा',
  AppString.pleaseMobileNumber: 'कृपया मोबाईल नंबर टाका',
  AppString.pleaseEnterValidMobileNumber:
      'कृपया वैध मोबाईल क्रमांक प्रविष्ट करा',
  AppString.pleaseEnterEmailId: 'कृपया ईमेल आयडी प्रविष्ट करा',
  AppString.pleaseEnterPin: "कृपया पिन प्रविष्ट करा",
  AppString.pleaseEnterConfirmPin: "कृपया एंटर पिनची पुष्टी करा",
  AppString.pleaseEnterAdharNumber: 'कृपया आधार क्रमांक प्रविष्ट करा',
  AppString.pleaseEnterValidAdharNumber: 'कृपया वैध आधार क्रमांक प्रविष्ट करा',
  AppString.pleasePickAdharPhotofront: 'कृपया आधार फोटो निवडा (समोरचा)',
  AppString.pleasePickAdharPhotoBack: 'कृपया आधार फोटो निवडा (मागे)',
  AppString.referralCode: 'रेफरल कोड',
  AppString.iAgreeToTheTermAndCondition: "मी नियम आणि अटीशी सहमत आहे",
  AppString.verifyOtp: "Otp सत्यापित करा",
  AppString.recharge: 'रिचार्ज करा',
  AppString.withdraw: 'मागे घ्या',
  AppString.sendRupees: 'रुपये पाठवा',
  AppString.lockAmount: 'लॉक रक्कम',
  AppString.myAvailableBalance: "माझी उपलब्ध शिल्लक",
  AppString.aMessageWithAVerification:
      "व्हेरिफिकेशन कोड असलेला मेसेज मोबाईल नंबरवर पाठवला होता:",
  AppString.pinOrConfirmPinNotMatch: "पिन किंवा पिन जुळत नसल्याची पुष्टी करा",
  AppString.pleaseCheckATermsAndCondition: "कृपया अटी आणि शर्ती तपासा",
  AppString.confirmRide: "राइड निश्चित करा",
  AppString.totalMoney: "एकूण पैसे:",
  AppString.totalDuration: "एकूण कालावधी:",
  AppString.totalDistance: "एकूण अंतर:",
  AppString.dashboard: "डॅशबोर्ड",
  AppString.accept: "स्वीकारा",
  AppString.reject: "नकार द्या",
  AppString.pleaseSelectAAadhaarImageFront: "कृपया आधार प्रतिमा (समोर) निवडा!",
  AppString.enterYourFeedBack: 'तुमचा अभिप्राय प्रविष्ट करा',
  AppString.postYourReview: "तुमचे पुनरावलोकन पोस्ट करा",
  AppString.pickupLocation: "पिकअप स्थान",
  AppString.dropLocation: "स्थान ड्रॉप करा",
  AppString.setMap: "नकाशा सेट करा",
  AppString.theFeedbackIGave: 'मी दिलेला फीडबॅक',
  AppString.theFeedbackIReceived: 'मला मिळालेला फीडबॅक',
  AppString.pleaseEnterOtp: "कृपया ओटीपी प्रविष्ट करा!",
  AppString.pleaseValidEnterOtp: "कृपया वैध ओटीपी प्रविष्ट करा!",
  AppString.copyRight: "कॉपीराइट",
  AppString.termsConditions: "अटी व शर्ती",
  AppString.privacyPolicy: "गोपनीयता धोरण",
  AppString.dataProviders: "डेटा प्रदाता",
  AppString.softwareLincences: "सॉफ्टवेअर लायन्सेस",
  AppString.locationInformation: "स्थान माहिती",
  AppString.cityRegulations: "शहराचे नियम",
  AppString.edit: "सुधारणे",
  AppString.sOS: "SOS",
  AppString.enterAPickupPoint: "पिकअप पॉइंट एंटर करा",
  AppString.youSavedUpToOnYourAutoRide:
      "तुम्ही तुमच्या ऑटो राइडवर \$3 पर्यंत बचत केली आहे!",
  AppString.auto: "ऑटो",
  AppString.rideNow: "आता राइड करा",
  AppString.couponApplied: "कूपन लागू केले",
  AppString.cash: "रोख",
  AppString.youCanPayViaOrUpi:
      "तुम्ही तुमच्या राइडसाठी रोख किंवा upi द्वारे पैसे देऊ शकता",
  AppString.bookRide: "बुक राइड",
  AppString.dashBoard: "डॅशबोर्ड",
  AppString.withCompanyLogo: "कंपनी लोगोसह",
  AppString.close: "बंद",
  AppString.yourTransactionIsSuccessfully:
      "तुमचा व्यवहार यशस्वीरित्या पूर्ण झाला आहे",
  AppString.firstRideBonus: "प्रथम राइड बोनस",
  AppString.welcomeBonus: "स्वागत बोनस",
  AppString.sharingAppBonus: "शेअरिंग ॲप बोनस",
  AppString.rideCompleted: "राइड पूर्ण झाली",
  AppString.receivedFromFriend: "मित्राकडून मिळाले",
};
