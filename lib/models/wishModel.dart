class Wish {
  String id;
  String content;

  Wish({this.id = '', this.content});

  Wish.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.content = obj['content'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['content'] = content;

    return map;
  }

  @override
  String toString() {
    return 'id: ${this.id}, content: ${this.content}';
  }
}
