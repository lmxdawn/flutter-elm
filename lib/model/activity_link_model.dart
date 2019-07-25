class ActivityLinkModel {
  String content;
  String imghash;
  String info;
  String title;
  String url;

  ActivityLinkModel({this.content, this.imghash, this.info, this.title, this.url});

  ActivityLinkModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    imghash = json['imghash'];
    info = json['info'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['imghash'] = this.imghash;
    data['info'] = this.info;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}