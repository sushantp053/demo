
class User {
  // img TEXT
  int _id;
  String _name;
  String _pass;
  String _email;
  String _dob;
  String _img;


  User(this._name, this._pass, this._email, this._dob,this._img);

  User.withId(this._id, this._name, this._pass,this._email, this._dob, this._img);

  int get id => _id;

  String get pass => _pass;
  String get dob => _dob;
  String get img => _img;

  String get name => _name;
  String get email => _email;

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
  set dob(String newdob) {
    if (newdob.length <= 255) {
      this._pass = newdob;
    }
  }
  set img(String newImg) {
    if (newImg.length <= 255) {
      this._pass = newImg;
    }
  }
  set email(String newId) {
    if (newId.length <= 255) {
      this._email = newId;
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
    map['email'] = _email;
    map['dob'] = _dob;
    map['img'] = _img;

    return map;
  }

  // Extract a Note object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._pass = map['pass'];
    this._email = map['email'];
    this._dob = map['dob'];
    this._img = map['img'];
  }
}
