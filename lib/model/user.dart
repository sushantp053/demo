
class User {
  int _id;
  String _name;
  String _pass;
  String _userid;


  User(this._name, this._pass, this._userid);

  User.withId(this._id, this._name, this._pass,this._userid);

  int get id => _id;

  String get pass => _pass;

  String get name => _name;
  String get userid => _userid;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }
  set pass(String newPass) {
    if (newPass.length <= 255) {
      this._pass = newPass;
    }
  }
  set userid(String newId) {
    if (newId.length <= 255) {
      this._userid = newId;
    }
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['pass'] = _pass;
    map['userid'] = _userid;

    return map;
  }

  // Extract a Note object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._pass = map['pass'];
    this._userid = map['userid'];
  }
}
