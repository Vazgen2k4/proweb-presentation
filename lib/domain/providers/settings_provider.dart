// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:proweb_presentations_web/domain/json_convertors/directions.dart';

class SettingsProvider extends ChangeNotifier {
  // Данные
  // Имя направления для добавления нового направления
  final _nameDirectionController = TextEditingController();
  TextEditingController get nameDirectionController => _nameDirectionController;

  // Почта нового админа
  final _adminEmailController = TextEditingController();
  TextEditingController get adminEmailController => _adminEmailController;

  final _teacher = AddTeacherModel();
  AddTeacherModel get teacher => _teacher;

  final _dirModel = DirectionsControllModel();
  DirectionsControllModel get dirModel => _dirModel;

  Future addDirection() async {
    final directionDocs = await AppFirebaseCollections.directions.get();
    final length = directionDocs.docs.length;

    if (length == -1) return;

    final curentTitle = _nameDirectionController.value.text.trim();
    final curentReplaceTitle = curentTitle.replaceAll(' ', '');

    _nameDirectionController.clear();

    for (var doc in directionDocs.docs) {
      final String? title = doc.get('title');

      if (title == null) return;

      final docTitle = title.trim().replaceAll(' ', '');

      if (docTitle.toLowerCase() == curentReplaceTitle.toLowerCase()) return;
    }

    final Map<String, dynamic> direction = {
      "id": length,
      "title": curentTitle,
      "teachers": [],
    };

    await AppFirebaseCollections.directions.add(direction);
  }

  Future addAdmin() async {
    final adminDocs = await AppFirebaseCollections.admins.get();

    final curentEmail =
        _adminEmailController.value.text.trim().replaceAll(' ', '');

    for (var doc in adminDocs.docs) {
      final String? email = doc.get('email');

      if (email == null) return;

      final emailField = email.trim().replaceAll(' ', '');

      if (emailField.toLowerCase() == curentEmail.toLowerCase()) return;
    }

    await AppFirebaseCollections.admins.add({
      "email": curentEmail.toLowerCase(),
      "primary": false,
    });

    _adminEmailController.clear();
  }

  Future removeAdmin(String email) async {
    if (email.trim().isEmpty) return;

    final adminDocs = await AppFirebaseCollections.admins.get();
    final doc = adminDocs.docs.firstWhere(
      (e) => e['email'].trim().toLowerCase() == email.trim().toLowerCase(),
    );

    await AppFirebaseCollections.admins.doc(doc.id).delete();
  }
}

class AddTeacherModel {
  // Имя Преподавателя
  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  // Ссылка на презентацию
  final _presLinkController = TextEditingController();
  TextEditingController get presLinkController => _presLinkController;

  // Направление преподавателя
  final _dirNameController = TextEditingController();
  TextEditingController get dirNameController => _dirNameController;

  // Файл
  late File _imgFile;
  String _imagePath = '';

  void clearControllers() {
    _nameController.clear();
    _presLinkController.clear();
    _dirNameController.clear();
  }

  Future addTeacher() async {
    final name = _nameController.value.text.trim();
    final link = _presLinkController.value.text.trim();
    final direction = _dirNameController.value.text.trim();

    clearControllers();

    if (name.isEmpty || link.isEmpty || direction.isEmpty) return;

    uploadImg().then((_) async {
      final dirs = await AppFirebaseCollections.directions
          .where('title', isEqualTo: direction)
          .get();

      final curentDirection = Directions.fromJson(dirs.docs.first.data());
      curentDirection.teachers?.add(Teachers(
        img: _imagePath,
        lang: 'ru',
        link: link,
        name: name,
      ));

      await AppFirebaseCollections.directions
          .doc(dirs.docs.first.id)
          .update(curentDirection.toJson());
    });
  }

  Future uploadImg() async {
    final file = _imgFile;

    final time = DateTime.now();

    final path =
        'images/${_nameController.value.text.trim()}-${time.millisecondsSinceEpoch}';
    _imagePath = path;

    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putBlob(file);
  }

  Future choseImg() async {
    final uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;

      if (file != null) {
        final reader = FileReader();
        reader.readAsDataUrl(file);
        reader.onLoad.listen((event) {
          _imgFile = file;
        });
      }
    });
  }

  Future removeTeacher({required String path}) async {
    final desertRef = FirebaseStorage.instance.ref().child(path);

    final data = await AppFirebaseCollections.directions.get();

    final doc = data.docs.firstWhere((item) {
      final teachers = item['teachers'] as List<dynamic>;
      bool _hasPath = false;
      for (var el in teachers) {
        if (el['img'] == path) {
          _hasPath = true;
        }
      }
      return _hasPath;
    });

    final _teachers = doc.get('teachers') as List;

    _teachers.removeWhere((element) {
      return element["img"] == path;
    });

    await AppFirebaseCollections.directions
        .doc(doc.id)
        .update({"teachers": _teachers});

    await desertRef.delete();
  }
}

class DirectionsControllModel {
  final _newDirNameContorller = TextEditingController();
  TextEditingController get newDirNameContorller => _newDirNameContorller;

  Future changeDirection(String title) async {
    final newTitle = _newDirNameContorller.value.text.trim();
    if (title.trim().isEmpty || newTitle.isEmpty) {
      _newDirNameContorller.clear();
      return;
    }

    final directions = await AppFirebaseCollections.directions.get();

    final curentDir = directions.docs.where((dir) => dir["title"] == title);
    final hasDir = directions.docs.where((dir) =>
        dir["title"].trim().toLowerCase() == newTitle.trim().toLowerCase());

    if (curentDir.isEmpty || curentDir.length > 1 || hasDir.isNotEmpty) {
      _newDirNameContorller.clear();
      return;
    }

    await AppFirebaseCollections.directions.doc(curentDir.first.id).update({
      "title": newTitle,
    });

    _newDirNameContorller.clear();
  }

  Future deleteDirection(String title) async {
    if (title.trim().isEmpty) return;

    final directions = await AppFirebaseCollections.directions.get();
    final curentDir =
        directions.docs.firstWhere((dir) => dir["title"] == title);

    await AppFirebaseCollections.directions.doc(curentDir.id).delete();
  }
}
