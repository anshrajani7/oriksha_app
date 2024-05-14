import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/Legal_page/controller/legal_controller.dart';

import '../../widget/custom_pdf_viewer.dart';

class LegalScreen extends GetWidget<LegalController> {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          onPressed: (){
            Get.back();
          },
          text: AppString.legal.tr,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: w(context, 15),vertical: h(context, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customText(context: context, text: AppString.copyRight.tr, onTap: () {  },),
            const Divider(),
            _customText(context: context, text: AppString.termConditions.tr, onTap: () {   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PdfViewScreen(title: 'Terms and Conditions', finaleParth: 'assets/app_image/2_Terms and Conditions.pdf', fileName: 'sample7.pdf',)),
            ); },),
            const Divider(),
            _customText(context: context, text: AppString.privacyPolicy.tr, onTap: () {  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PdfViewScreen(title: 'Privacy Policy', finaleParth: 'assets/app_image/3_Privacy Policy.pdf', fileName: 'sample3.pdf',)),
            );  },),
            const Divider(),
            _customText(context: context, text: AppString.dataProviders.tr, onTap: () {  },),
            const Divider(),
            _customText(context: context, text: AppString.softwareLincences.tr, onTap: () {  },),
            const Divider(),
            _customText(context: context, text: AppString.locationInformation.tr, onTap: () {  },),
            const Divider(),
            _customText(context: context, text: AppString.cityRegulations.tr, onTap: () {  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PdfViewScreen(title: 'City Regulations', finaleParth: 'assets/app_image/Motor_vehicle_act_May_2023.pdf', fileName: 'sample5.pdf',)),
            ); },),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _customText({required BuildContext context, required String text,required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: h(context, 5)),
        child: Text(
          text,
          style: AppStyle.style(f(context, 13),
              fontColor: ColorConstant.primaryBlack, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
