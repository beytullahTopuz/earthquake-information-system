class Earthquake_model {
  int id;
  String title;
  String description;
  String link;
  String pubDate;
  Earthquake_model(
      {this.id, this.title, this.description, this.link, this.pubDate});

  Earthquake_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    pubDate = json['pubDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['link'] = this.link;
    data['pubDate'] = this.pubDate;
    return data;
  }
}
