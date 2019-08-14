class Image {
  var _id;
  var _title;
  var _url;
  var _available = true;

  Image(this._id, this._title, this._url, this._available);

  Image.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _title = json['title'],
        _url = json['url'],
        _available = json['available'];

  Map<String, dynamic> toJson() =>
      {"id": _id, "title": _title, "url": _url, "available": _available};
}
