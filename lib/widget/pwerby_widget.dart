import 'package:oriksha_application/core/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

class PowerByWigdet extends StatelessWidget {
  const PowerByWigdet({super.key});

  @override
  Widget build(BuildContext context) {
    return           Container(
      height: h(context, 45),
      width: double.maxFinite,
      decoration: const BoxDecoration(color: ColorConstant.primaryOrg,borderRadius: BorderRadius.only(topRight: Radius.circular(100))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppString.poewBy,
              style: AppStyle.style(f(context, 14), fontWeight: FontWeight.w400,fontColor: ColorConstant.primaryBlack,)),
          Gap(w(context, 5)),
          GestureDetector(
            onTap: ()async{
              if (await canLaunch('https://dddigitalsolution.com/')) {
                await launch('https://dddigitalsolution.com/');
              } else {
                throw 'Could not launch https://dddigitalsolution.com/';
              }
            },
            child: Text(
              AppString.cmpFullName,
              style: AppStyle.style(f(context, 14), fontWeight: FontWeight.w700,fontColor: ColorConstant.primaryBlack),
            ),
          ),
        ],
      ),
    );
  }
}
