import 'package:flutter/material.dart';

class SettingMenuTitle extends StatelessWidget {
  const SettingMenuTitle({
    super.key,
    required this.iconLeading,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData iconLeading;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // ----- Start Icon Menu
      leading: Icon(iconLeading),

      // ----- Menu Title
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),

      // ----- Menu Description
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),

      // ----- End Icon Menu
      trailing: trailing,
      onTap: onTap,
    );
  }
}
