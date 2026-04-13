import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/extensions/widget_extension.dart';

class LeadingIconWithText extends BaseStatelessWidget {
  final String? icon;
  final Widget? iconWidget;
  final String? text;
  final TextStyle textStyle;
  final double? iconHeight;
  final double? iconWidth;
  final Color? iconColor;
  final double space;
  final Widget? title;
  final bool isLeadingIcon;
  final void Function()? onTap;

  const LeadingIconWithText({
    super.key,
    this.icon,
    this.text,
    required this.textStyle,
    this.iconHeight,
    this.iconWidth,
    this.iconColor,
    this.space = 5,
    this.title,
    this.isLeadingIcon = true,
    this.onTap,
    this.iconWidget,
  });

  @override
  Widget buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          FocusManager.instance.primaryFocus?.unfocus();
          onTap!();
        }
      },
      child: Padding(
        padding: onTap != null ? const EdgeInsets.symmetric(vertical: 5, horizontal: 3) : EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLeadingIcon) ..._buildIconWidget(),
            if (isLeadingIcon) SizedBox(width: space),
            if (title != null) title! else Text(text ?? "", style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis).withFlexible(),
            if (!isLeadingIcon) SizedBox(width: space),
            if (!isLeadingIcon) ..._buildIconWidget(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIconWidget() {
    if (iconWidget != null) return [iconWidget!];
    return [
      if (icon != null && icon!.endsWith(".svg"))
        SvgPicture.asset(icon!, height: iconHeight, colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null)
      else
        Image.asset(icon ?? "", height: iconHeight, fit: BoxFit.cover, width: iconWidth),
    ];
  }
}
