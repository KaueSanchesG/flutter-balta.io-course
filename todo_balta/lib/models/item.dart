class Item {
  String title;
  bool isDone;

  Item(this.title, this.isDone);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['title'], json['isDone']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isDone': isDone};
  }
}
