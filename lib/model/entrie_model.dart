class EntrieModel {
  int id;
  String backgroundColor;
  String imageHash;
  String link;
  String name;
  String nameColor;

  EntrieModel(
      {this.id,
      this.backgroundColor,
      this.imageHash,
      this.link,
      this.name,
      this.nameColor});

  EntrieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    backgroundColor = json['background_color'];
    imageHash = json['image_hash'];
    link = json['link'];
    name = json['name'];
    nameColor = json['name_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['background_color'] = this.backgroundColor;
    data['image_hash'] = this.imageHash;
    data['link'] = this.link;
    data['name'] = this.name;
    data['name_color'] = this.nameColor;
    return data;
  }
}