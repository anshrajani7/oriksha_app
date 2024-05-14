import 'package:oriksha_application/core/app_export.dart';

class CustomTextButton extends StatelessWidget {
 final void Function() onPressed;
  final String buttonName;
  final Color? buttonColor;
   const CustomTextButton({super.key,required this.buttonName,required this.onPressed, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w(context, 160),
      child: TextButton(
          onPressed:onPressed,
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.grey,
              elevation: 4,
              foregroundColor: Colors.white,
              splashFactory: InkRipple.splashFactory,
              surfaceTintColor: ColorConstant.transparent,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor:buttonColor?? ColorConstant.primaryOrg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          ),
          child: Text(
           buttonName,
            style: AppStyle.style(f(context, 16),
                fontColor:ColorConstant.primaryWhite, fontWeight: FontWeight.w600),
          )),
    );
  }
}
