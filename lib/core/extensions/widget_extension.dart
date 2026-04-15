import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

extension TextWidgetExtension on Text {
  /// Wraps this [Text] in a [Flexible] + [Row] and appends a bullet dot after it.
  Widget appendDot({TextOverflow overflow = TextOverflow.ellipsis}) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(data ?? '', style: style, textAlign: textAlign, maxLines: maxLines, overflow: overflow, softWrap: softWrap),
          ),
          const SizedBox(width: 6),
          Text(
            '\u2022',
            style: (style ?? const TextStyle()).copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: ColorPalette.astroscopusGrey),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }

  /// Wraps this [Text] in a [Flexible] widget, preserving all styling.
  Widget withFlexible({TextOverflow overflow = TextOverflow.ellipsis}) {
    return Flexible(
      child: Text(data ?? '', style: style, maxLines: maxLines, overflow: overflow, textAlign: textAlign, softWrap: softWrap),
    );
  }
}
