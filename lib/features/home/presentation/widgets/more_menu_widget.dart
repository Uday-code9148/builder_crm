import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

class MoreMenuWidget extends StatelessWidget {
  const MoreMenuWidget({super.key});

  void showMoreMenu(BuildContext context, Offset position) async {
    await showMenu(
      context: context,
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("More", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
        PopupMenuItem(child: _menuItem(Icons.storefront_outlined, "Become a Seller")),
        PopupMenuItem(child: _menuItem(Icons.notifications_outlined, "Notification Settings")),
        PopupMenuItem(child: _menuItem(Icons.headset_mic_outlined, "24x7 Customer Care")),
        PopupMenuItem(child: _menuItem(Icons.campaign_outlined, "Advertise on Flipkart")),
      ],
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.black87),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        showMoreMenu(context, details.globalPosition);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.storefront_outlined, color: ColorPalette.txtGreenColor),
      ),
    );
  }
}
