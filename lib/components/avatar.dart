import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar(
      {super.key,
      this.url,
      this.radius = 17,
      this.hasStatus = false,
      this.ringColor = Colors.black});

  final String? url;
  final Color ringColor;
  final bool hasStatus;
  double radius;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (hasStatus) {
      radius -= 2.3;

      if (url != null) {
        child = buildNetworkImageAvatar(url!, radius);
      } else {
        child = buildImageAvatar(radius);
      }

      return addAvatarStatusRing(context, child, ringColor);
    }

    if (url != null) {
      child = buildNetworkImageAvatar(url!, radius);
    } else {
      child = buildImageAvatar(radius);
    }

    return child;
  }
}

// This is the ring around the avatar
Widget addAvatarStatusRing(
    BuildContext context, Widget child, Color ringColor) {
  return Container(
    padding: const EdgeInsets.all(1.3), // Add padding if you want a border
    decoration: BoxDecoration(
      color: ringColor, // Border color
      shape: BoxShape.circle,
    ),
    child: Container(
      padding: const EdgeInsets.all(1), // Add padding if you want a border
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary, // Border color
        shape: BoxShape.circle,
      ),
      child: child,
    ),
  );
}

Widget buildNetworkImageAvatar(String imageUrl, double radius) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => buildImageAvatar(radius),
    imageBuilder: (context, image) => CircleAvatar(
      backgroundImage: image,
      radius: radius,
    ),
    errorWidget: (context, url, error) => buildImageAvatar(radius),
    fit: BoxFit.scaleDown,
  );
}

Widget buildImageAvatar(double radius) {
  return CircleAvatar(
    radius: radius,
    backgroundImage: const AssetImage("assets/images/person.jpg"),
  );
}
