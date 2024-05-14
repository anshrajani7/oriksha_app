import '../core/app_export.dart';
class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintFontStyle;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final FocusNode? focusNode;
  final bool? isObscureText;
  final int? maxLength;
  final bool? isDense;
  final bool? readOnly;
  final String? richText;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormated;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int maxLine;
  const CustomTextFormField(
      {super.key,
      this.textInputAction,
      this.labelText = '',
      this.controller,
      this.textStyle,
      this.prefixIcon,
      this.textInputType,
      this.suffixIcon,
      this.hintText,
      this.focusNode,
      this.isObscureText = false,
      this.validator,
      this.inputFormated,
      this.onChanged,
      this.hintFontStyle,
      this.isDense = true,
      this.onTap,
      this.maxLine = 1,
      this.richText, this.maxLength, this.readOnly});

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
        Container(
          height: 45,
          padding:
              EdgeInsets.only(left: prefixIcon == null ? w(context, 18) : 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(maxLine > 2 ? 18 : 35),
              color: ColorConstant.primaryWhite),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextFormField(
                  maxLength: maxLength,
                  onChanged: onChanged,
                  focusNode: focusNode,
                  maxLines: maxLine ,
                  onTap: onTap ?? () {},
                  obscureText: isObscureText!,
                  validator: validator,
                  inputFormatters: inputFormated ?? [],
                  textInputAction: textInputAction ?? TextInputAction.none,
                  keyboardType: textInputType ?? TextInputType.text,
                  controller: controller,
                  readOnly: readOnly??false,

                  style: textStyle ??
                      AppStyle.style(f(context, 19),
                          fontWeight: FontWeight.w400, fontFamily: "Inter"),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: h(context, 5)),
                    isDense: false,
                    hintText: hintText ?? "",
                    hintStyle: hintFontStyle ??
                        AppStyle.style(
                          f(context, 16),
                        ),
                    prefixIcon: prefixIcon != null
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: w(context, 15),
                                right: w(context, 10),
                                bottom: maxLine > 2 ? 65 : 0),
                            child: prefixIcon,
                          )
                        : null,
                    suffixIcon: suffixIcon,
                    // contentPadding: EdgeInsets.only(
                    //   left: w(context, 20),
                    // ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomAppTextFormField extends StatelessWidget {
  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextStyle? fontStyle;
  TextStyle? hintFontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;
  bool? enabled;

  TextInputAction? textInputAction;

  TextInputType? textInputType;

  int maxLines;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  String? initialValue;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;

  bool? readOnly;
  bool autofocus;
  String? richText;
  List<TextInputFormatter>? inputFormated;

  Function()? onTap;

  Function(String)? onChanged;
  final String labelText;
  final int? maxLength;

  CustomAppTextFormField({
    super.key,
    this.shape,
    this.inputFormated,
    this.padding,
    this.variant,
    this.richText,
    this.fontStyle,
    this.hintFontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines=1,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.readOnly,
    this.onTap,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.labelText = '', this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  _buildTextFormFieldWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Container(
          width: width ?? double.maxFinite,
          margin: margin ?? EdgeInsets.symmetric(vertical: h(context, 5)),
          child: TextFormField(
            initialValue: initialValue,
            controller: controller,
            enabled: enabled,
            readOnly: readOnly ?? false,
            onTap: onTap,
            onChanged: onChanged,
            focusNode: focusNode,
            autofocus: autofocus,
            style: fontStyle ?? AppStyle.style(f(context, 16)),
            obscureText: isObscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines,
            maxLength: maxLength,
            decoration: _buildDecoration(context),
            validator: validator,
            inputFormatters: inputFormated ?? [],
          ),
        ),
      ],
    );
  }

  _buildDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: hintFontStyle ?? AppStyle.style(f(context, 14)),
      border: _setBorderStyle(context),
      enabledBorder: _setBorderStyle(context),
      focusedBorder: _setBorderStyle(context),
      disabledBorder: _setBorderStyle(context),
      prefixIcon: maxLines>2?Padding(
        padding: EdgeInsets.only(
            left: 15,
            right: 10,
            bottom: maxLines > 2 ? 65 : 0),
        child: prefix,
      ):prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      // contentPadding: _setPadding(),
    );
  }

  _setOutlineBorderRadius(BuildContext context) {
    switch (shape) {
      case TextFormFieldShape.RoundedBorder18:
        return BorderRadius.circular(
          h(
            context,
            18.00,
          ),
        );

      default:
        return BorderRadius.circular(35);
    }
  }

  _setBorderStyle(BuildContext context) {
    switch (variant) {
      case TextFormFieldVariant.White:
        return OutlineInputBorder(
            borderRadius: _setOutlineBorderRadius(context),
            borderSide: BorderSide.none);
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(context),
          borderSide: const BorderSide(
            color: ColorConstant.greyColorB3,
            width: 0,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return ColorConstant.primaryWhite;
      default:
        return ColorConstant.primaryWhite;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

// _setPadding() {
//   switch (padding) {
//     case TextFormFieldPadding.PaddingT13:
//       return getPadding(
//         left: 12,
//         top: 13,
//         bottom: 13,
//       );
//     default:
//       return getPadding(
//         left: 12,
//         top: 16,
//         right: 12,
//         bottom: 16,
//       );
//   }
// }
}

enum TextFormFieldShape {
  RoundedBorder12,
  RoundedBorder18,
}

enum TextFormFieldPadding {
  PaddingT14,
  PaddingT13,
}

enum TextFormFieldVariant {
  None,
  OutlineGray200,
  White,
}

enum TextFormFieldFontStyle {
  GilroyMedium16Bluegray40001,
  GilroyMedium16,
  txtGilroyMedium
}
