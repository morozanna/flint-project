class Wish {
  String id;
  String _content;

  Wish(this.id, this._content);

  String get content => _content;

  Wish.fromMap(dynamic obj) {
    this.id = obj['id'];
    this._content = obj['content'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['content'] = _content;

    return map;
  }
}
