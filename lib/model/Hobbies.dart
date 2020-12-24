class Hobbies {
  int _id;
  int _userId;
  String _hobby;

//userId INTEGER,
  Hobbies(this._hobby, this._userId);

  Hobbies.withId(this._id, this._hobby, this._userId,);

  int get id => _id;

  int get userId => _userId;

  String get hobby => _hobby;

  set hobby(String newhobby) {
    if (newhobby.length <= 255) {
      this._hobby = newhobby;
    }
  }

  set userId(int newuserId) {
    this._userId = newuserId;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['hobby'] = _hobby;
    map['userId'] = _userId;

    return map;
  }

  // Extract a Note object from a Map object
  Hobbies.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._hobby = map['hobby'];
    this._userId = map['userId'];
  }
}
