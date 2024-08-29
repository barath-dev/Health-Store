import 'package:flutter/material.dart';
import 'package:healzero/core/app_exports.dart';
import 'package:healzero/core/utils/image_constants.dart';

class CircleAvatarImage extends StatelessWidget {
  const CircleAvatarImage({super.key, required this.imageUrl, this.radius=30,});
  final String imageUrl;
  final double? radius ;
  @override
  Widget build(BuildContext context) {
    // show image in dialog.
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                height: 300.v,
                width: 300.h,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.transparent,
                  image: DecorationImage(
                    image: imageUrl.isEmpty
                        ? AssetImage(
                            ImageConstants.personImage,
                          )
                        : NetworkImage(
                            imageUrl,
                          ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: radius?? 30,
        backgroundImage: imageUrl.isEmpty
            ? AssetImage(
                ImageConstants.personImage,
              )
            : NetworkImage(
                imageUrl,
              ),
      ),
    );
  }
}
