class Directions {
  int? id;
  String? title;
  List<Teachers>? teachers;

  Directions({this.id, this.title, this.teachers});

  Directions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(Teachers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    if (teachers != null) {
      data['teachers'] = teachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teachers {
  String? name;
  String? img;
  String? link;
  String? lang;

  Teachers({this.name, this.img, this.link, this.lang});

  Teachers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    link = json['link'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['img'] = img;
    data['link'] = link;
    data['lang'] = lang;
    return data;
  }
}
