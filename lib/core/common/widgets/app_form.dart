import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/theme/app_theme.dart';

class AppForm extends BaseStatelessWidget {
  final Widget child;
  final Key? formKey;
  final Widget leadingButton;
  final Widget trailingButton;
  final AppBar? appBar;
  final bool wrapWithScrollView;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool forceDarkTheme;

  const AppForm({
    required this.leadingButton,
    required this.trailingButton,
    super.key,
    required this.child,
    this.formKey,
    this.appBar,
    this.padding,
    this.wrapWithScrollView = true,
    this.backgroundColor,
    this.forceDarkTheme = true,
  });

  @override
  Widget buildContent(BuildContext context) {
    Widget content = Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 24, right: 14, top: 32, bottom: 20),
        child: Row(
          children: [
            leadingButton,
            const SizedBox(width: 14),
            Expanded(child: trailingButton),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: padding ?? const EdgeInsets.only(left: 24, right: 14),
          decoration: BoxDecoration(
            color: backgroundColor ?? ColorPalette.white,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: Form(
            key: formKey,
            child: wrapWithScrollView ? SingleChildScrollView(child: child) : child,
          ),
        ),
      ),
    );

    final Widget formContent = forceDarkTheme ? Theme(data: AppTheme.darkTheme, child: content) : content;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          Theme.of(context).appBarTheme.systemOverlayStyle ??
          (Theme.of(context).brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
      child: formContent,
    );
  }
}
