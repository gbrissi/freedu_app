import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../http/models/picker_image.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.url,
    this.radius = 14,
  }) : bytes = null;

  const Avatar.fromImageBytes({
    super.key,
    this.radius = 14,
    required this.bytes,
  }) : url = null;

  Avatar.fromImageData({
    super.key,
    this.radius = 14,
    required ImageData? img,
  })  : url = img?.url,
        bytes = img?.bytes;

  final Uint8List? bytes;
  final String? url;
  final double radius;
  static const String picPlaceholder =
      "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671116.jpg?t=st=1701730413~exp=1701731013~hmac=e8c9002b2a3f11e079e7782fed2df87a50275e0980879e4ab9ed00ea7c638e9f";

  ImageProvider<Object> get backgroundImg => bytes != null
      ? MemoryImage(bytes!) as ImageProvider
      : NetworkImage(
          url ?? picPlaceholder,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Image(
          image: backgroundImg,
          fit: BoxFit.cover,
        ),
      ),
    );
    // return CircleAvatar(
    //   radius: radius,
    //   backgroundImage: backgroundImg,
    // );
  }
}
