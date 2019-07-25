class BannerModel {
  int id;
  String imageHash;
  String url;

  BannerModel({this.id, this.imageHash, this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageHash = json['image_hash'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_hash'] = this.imageHash;
    data['url'] = this.url;
    return data;
  }
}