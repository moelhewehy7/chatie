import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.userModel,
    required this.radius,
    required this.doubleRadius,
  });

  final UserModel userModel;
  final double radius;
  final double doubleRadius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: userModel.profilePic! != FireStorage().alternativeImage
              ? userModel.profilePic!
              : FireStorage().alternativeImage,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.primaryContainer,
            highlightColor: Theme.of(context).colorScheme.secondaryContainer,
            child: Container(
              width: doubleRadius,
              height: doubleRadius,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
          ),
        ),
      ),
    );
  }
}
