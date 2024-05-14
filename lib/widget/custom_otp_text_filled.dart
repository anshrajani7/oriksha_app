import 'package:oriksha_application/core/app_export.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CustomOtpTextFilled extends StatelessWidget {
final String labelText;
final String? richText;
  final bool? obscureText;

  final Function(String)? onSubmit;

  final Function(String)? onCordChange;
  final void Function(List<TextEditingController?>)? controller;

  const CustomOtpTextFilled(
      {super.key,
        this.obscureText,
        this.onSubmit,
        this.onCordChange, this.labelText='', this.richText, this.controller,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        labelText.isNotEmpty
            ? Padding(
          padding: EdgeInsets.symmetric(
              vertical: h(context, 2), horizontal: w(context, 14)),
          child: RichText(
              textScaleFactor: 1,
              text: TextSpan(
                text: '$labelText ',
                style: AppStyle.style(f(context, 14),
                    fontColor: ColorConstant.primaryBlack,
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                    text: richText ?? '',
                    style: AppStyle.style(
                      f(context, 18),
                      fontColor: Colors.red,
                    ),
                  ),
                ],
              )),
        )
            : const SizedBox(),
        OtpTextField(
          keyboardType: TextInputType.number,
          mainAxisAlignment: MainAxisAlignment.center,
          numberOfFields: 4,
          obscureText: obscureText ?? false,
          filled: true,
          handleControllers: controller,
          fillColor: ColorConstant.primaryWhite,
          borderColor: ColorConstant.primaryBlack,
          focusedBorderColor: ColorConstant.primaryBlack,
          showFieldAsBox: true,
          borderRadius: BorderRadius.circular(45),
          fieldWidth: w(context, 58),
          onCodeChanged: onCordChange,
          onSubmit: onSubmit,
        ),
      ],
    );
  }
}
