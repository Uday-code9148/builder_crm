import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/leading_icon_with_text.dart';
import 'package:temp_architecture_app_setup/core/extensions/string_extension.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

class AppTextFormField extends BaseStatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextEditingController? maskController;
  final String? Function(String? value)? validator;
  final bool isObscureText;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool isEnabled;
  final EdgeInsetsGeometry padding;
  final bool isRequired;
  final Widget? prefixIcon;
  final bool defaultPrefixIcon;
  final String? counterText;
  final void Function(String value)? onChanged;
  final bool showBudgetInWords;
  final String? currency;
  final Function()? previewFunction;
  final Color? inputTextColor;
  final Color? labelTextColor;
  final Widget? customTrailingWidget;
  final Color? disabledColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool takeDefaultBottomSpace;
  final GlobalKey<FormState>? formKey;
  final String Function(String value)? maskingStrategy;

  AppTextFormField({
    super.key,
    this.labelText,
    this.labelTextColor,
    this.hintText,
    this.controller,
    this.maskController,
    this.validator,
    this.isObscureText = false,
    this.maskingStrategy,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.isEnabled = true,
    this.padding = EdgeInsets.zero,
    this.isRequired = false,
    this.prefixIcon,
    this.defaultPrefixIcon = true,
    this.counterText,
    this.onChanged,
    this.showBudgetInWords = false,
    this.currency,
    this.previewFunction,
    this.inputFormatters,
    this.inputTextColor,
    this.customTrailingWidget,
    this.disabledColor,
    this.takeDefaultBottomSpace = true,
    this.formKey,
  }) {
    if (isObscureText && maskingStrategy != null) {
      (maskController ?? controller)?.text = maskingStrategy!(controller?.text ?? '');
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: padding,
      child: Form(
        key: formKey,
        child: FormField<String>(
          initialValue: controller?.text,
          validator: maskingStrategy != null ? null : validator,
          builder: (FormFieldState<String> state) {
            if (controller != null && controller!.text != state.value) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                state.didChange(controller!.text);
                state.validate();
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (labelText != null)
                      Text(labelText ?? '', style: AppTextStyles.s12SemiBold.copyWith(color: labelTextColor ?? ColorPalette.primaryDarkColor)),
                    if (isRequired) Text(' *', style: AppTextStyles.s12Medium.copyWith(color: const Color(0xFFEA4335))),
                    if (labelText != null) const Spacer(),
                    ?customTrailingWidget,
                    if (previewFunction != null && (controller?.text.isNotNullOrEmpty() ?? false))
                      LeadingIconWithText(
                        onTap: previewFunction,
                        text: 'Preview ',
                        textStyle: AppTextStyles.s12Medium.copyWith(color: ColorPalette.primaryGreen),
                        iconWidget: const Icon(Icons.visibility_outlined, size: 16, color: ColorPalette.primaryGreen),
                      ),
                  ],
                ),
                if (labelText != null) const SizedBox(height: 4),
                TextFormField(
                  keyboardType: keyboardType,
                  controller: maskController ?? controller,
                  inputFormatters: inputFormatters,
                  autofocus: false,
                  decoration: InputDecoration(
                    counterText: counterText,
                    hintText: hintText,
                    hintStyle: AppTextStyles.s12Regular.copyWith(color: ColorPalette.primary),
                    prefixIcon: defaultPrefixIcon
                        ? prefixIcon != null
                              ? Container(
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: ColorPalette.primaryTextColor),
                                  width: 36,
                                  child: prefixIcon,
                                )
                              : null
                        : prefixIcon,
                    fillColor: !isEnabled ? (disabledColor ?? ColorPalette.superSilver) : null,
                    filled: !isEnabled,
                    enabledBorder: _inputBorder(Color((state.errorText?.isEmpty ?? true) ? 0xFFE0E0E0 : 0xFFC73E1D)),
                    disabledBorder: _inputBorder(Color((state.errorText?.isEmpty ?? true) ? 0xFFE0E0E0 : 0xFFC73E1D)),
                    focusedBorder: _inputBorder(Color((state.errorText?.isEmpty ?? true) ? 0xFFE0E0E0 : 0xFFC73E1D)),
                  ),
                  obscureText: (isObscureText && maskingStrategy == null),
                  style: AppTextStyles.s12Regular.copyWith(color: inputTextColor ?? ColorPalette.primaryDarkColor, overflow: TextOverflow.ellipsis),
                  maxLines: maxLines,
                  maxLength: maxLength,
                  readOnly: readOnly,
                  onTap: onTap,
                  enabled: isEnabled,
                  cursorColor: ColorPalette.primaryGreen,
                  onChanged: (value) {
                    state.didChange(value);
                    state.validate();
                    if (onChanged != null) {
                      onChanged!(value);
                    }
                  },
                ),
                if (state.hasError || (showBudgetInWords && controller?.text != null) || takeDefaultBottomSpace)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: state.hasError
                          ? Text(
                              state.hasError ? state.errorText! : "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.s12Regular.copyWith(color: ColorPalette.cinnabar),
                            )
                          : (showBudgetInWords && controller?.text != null)
                          ? Text(
                              controller?.text.budgetToWord(currency) ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.s12Regular.copyWith(color: ColorPalette.primaryGreen),
                            )
                          : const Text(''),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder([Color color = ColorPalette.gray300]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
      borderRadius: BorderRadius.circular(6),
    );
  }
}
