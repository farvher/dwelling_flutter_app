class User {
  var _id;
  var _username;
  var _password;
  var _fistname;
  var _lastname;
  var _email;
  var _enabled;
  var _lastPasswordResetDate;
  var _authorities;
  var _token;


  User(this._username, this._password);

  User.fromJson(Map<String, dynamic> json) : _token = json['token'];

  Map<String, dynamic> toJson() =>
      {'username': _username, 'password': _password};

  get id => _id;

  set id(value) {
    _id = value;
  }

  get username => _username;

  set username(value) {
    _username = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  get fistname => _fistname;

  set fistname(value) {
    _fistname = value;
  }

  get lastname => _lastname;

  set lastname(value) {
    _lastname = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  get enabled => _enabled;

  set enabled(value) {
    _enabled = value;
  }

  get lastPasswordResetDate => _lastPasswordResetDate;

  set lastPasswordResetDate(value) {
    _lastPasswordResetDate = value;
  }

  get authorities => _authorities;

  set authorities(value) {
    _authorities = value;
  }

  get token => _token;

  set token(value) {
    _token = value;
  }
}
