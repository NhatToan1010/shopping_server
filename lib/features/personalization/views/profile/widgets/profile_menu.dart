import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    this.onTap, required this.leadingIcon,
  });

  final String title, value;
  final IconData icon, leadingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSize.small),
        child: ListTile(
          leading: Icon(leadingIcon, size: 16),

          title: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),

          subtitle: Expanded(
            flex: 5,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          trailing: Icon(icon, size: 16),
        ),
      ),
    );
  }
}
