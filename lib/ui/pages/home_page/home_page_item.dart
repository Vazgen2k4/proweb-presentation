import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:proweb_presentations_web/domain/json_convertors/directions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageItem extends StatelessWidget {
  final Teachers? teacher;
  final double radius;
  const HomePageItem({
    Key? key,
    this.radius = 20,
    required this.teacher,
  }) : super(key: key);

  Future<String> getUrl() async {
    return (await FirebaseStorage.instance
        .ref()
        .child(teacher!.img!)
        .getDownloadURL());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUrl(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Ink(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(snapshot.data.toString()),
            ),
          ),
          child: _CardWidget(radius: radius, teacher: teacher),
        );
      },
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    Key? key,
    required this.radius,
    required this.teacher,
  }) : super(key: key);

  final double radius;
  final Teachers? teacher;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () async {
        if (teacher != null && teacher?.link != null) {
          await launchUrl(Uri.parse(teacher!.link!));
        }
      },
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius - 2),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 12,
          ),
          child: Text(
            (teacher?.name ?? '123').toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              height: 1.22,
            ),
          ),
        ),
      ),
    );
  }
}
