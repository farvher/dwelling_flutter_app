import 'package:dwelling_flutter_app/model/image.dart';
import 'package:dwelling_flutter_app/model/property_types.dart';

class Property {
  var _id;
  var _title;
  var _images = <Image>[];
  var _imagesCount;
  var _propertyType = <PropertyType>[];
  var _neighborhood;
  var _zone;
  var _city;
  var _country;
  var _description;
  var _antiquitiy;
  var _rentPrice;
  var _sellPrince;
  var _area;
  var _areaUnit;
  var _rooms;
  var _stratum;
  var _buildTime;
  var _bathroom;
  var _parking;
  var _admon;
  var _floor;
  var _additional;
  var _latitude;
  var _longitude;


  Property.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _title = json['title'],
        _description = json['description'],
        _imagesCount = json['imageCount'],
        _antiquitiy = json['antiquitiy'],
        _rentPrice = json['rentPrice'],
        _sellPrince = json['sellPrince'],
        _area = json['area'],
        _areaUnit = json['areaUnit'],
        _rooms = json['rooms'],
        _stratum = json['stratum'],
        _buildTime = json['buildTime'],
        _bathroom = json['bathroom'],
        _parking = json['parking'],
        _admon = json['admon'],
        _floor = json['floor'],
        _latitude = json['latitude'],
        _longitude = json['longitude'],
        _images = (json['images'] as List).map((e) => Image.fromJson(e)).toList(),
        _propertyType = (json['propertyTypes'] as List).map((e) => PropertyType.fromJson(e)).toList()



  ;

  Map<String, dynamic> toJson() => {
        'id': _id,
        'propertyTypes': [
          {'id': 1, 'name': 'APARTAESTUDIO'},
          {'id': 2, 'name': 'CASA'}
        ],
        'title': _title,
        'neighborhood': {
          'id': 740,
          'name': _neighborhood,
          'zone': {
            'id': 551,
            'name': _zone,
            'city': {
              'id': 868,
              'name': _city,
              'country': {'id': 791, 'name': _country}
            }
          }
        },
        'description': _description,
        'imageCount': _imagesCount,
        'images': _images,
        'antiquitiy': _antiquitiy,
        'rentPrice': _rentPrice,
        'sellPrince': _sellPrince,
        'area': _area,
        'areaUnit': _areaUnit,
        'rooms': _rooms,
        'stratum': _stratum,
        'buildTime': _buildTime,
        'bathroom': _bathroom,
        'parking': _parking,
        'admon': _admon,
        'floor': _floor,
        'additional': [
          {'id': 504, 'value': 'piscina'},
          {'id': 639, 'value': 'Cancha de futbol'}
        ],
        'visitor': {
          'id': 115,
          'username': 'Stefanie',
          'name': 'Cruz',
          'lastname': 'Mccarty',
          'email': 'cruzmccarty@poshome.com',
          'age': 50,
          'creationDate': '2019-07-23',
          'phone': '+1 (983) 488-3082',
          'cellPhone': '+1 (910) 450-3169',
          'urlSite': 'www.site.com',
          'enable': true,
          'builder': null,
          'realState': {
            'id': 420,
            'name': 'CALLFLEX',
            'contact': {
              'id': 257,
              'contactName': 'Haley Strickland',
              'contactEmail': 'haleystrickland@callflex.com',
              'contactWebSite': 'www.site.com',
              'address1': 'Miller Place',
              'address2': 'Windsor Place',
              'address3': null,
              'phone1': '+1 (948) 499-3733',
              'phone2': '+1 (987) 465-3918',
              'phone3': null
            }
          }
        },
        'latitude': _latitude,
        'longitude': _longitude
      };

  get longitude => _longitude;

  set longitude(value) {
    _longitude = value;
  }

  get latitude => _latitude;

  set latitude(value) {
    _latitude = value;
  }

  get additional => _additional;

  set additional(value) {
    _additional = value;
  }

  get floor => _floor;

  set floor(value) {
    _floor = value;
  }

  get admon => _admon;

  set admon(value) {
    _admon = value;
  }

  get parking => _parking;

  set parking(value) {
    _parking = value;
  }

  get bathroom => _bathroom;

  set bathroom(value) {
    _bathroom = value;
  }

  get buildTime => _buildTime;

  set buildTime(value) {
    _buildTime = value;
  }

  get stratum => _stratum;

  set stratum(value) {
    _stratum = value;
  }

  get rooms => _rooms;

  set rooms(value) {
    _rooms = value;
  }

  get areaUnit => _areaUnit;

  set areaUnit(value) {
    _areaUnit = value;
  }

  get area => _area;

  set area(value) {
    _area = value;
  }

  get sellPrince => _sellPrince;

  set sellPrince(value) {
    _sellPrince = value;
  }

  get rentPrice => _rentPrice;

  set rentPrice(value) {
    _rentPrice = value;
  }

  get antiquitiy => _antiquitiy;

  set antiquitiy(value) {
    _antiquitiy = value;
  }

  get description => _description;

  set description(value) {
    _description = value;
  }

  get country => _country;

  set country(value) {
    _country = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get zone => _zone;

  set zone(value) {
    _zone = value;
  }

  get neighborhood => _neighborhood;

  set neighborhood(value) {
    _neighborhood = value;
  }

  get propertyType => _propertyType;

  set propertyType(value) {
    _propertyType = value;
  }

  get imagesCount => _imagesCount;

  set imagesCount(value) {
    _imagesCount = value;
  }

  get images => _images;

  set images(value) {
    _images = value;
  }

  get title => _title;

  set title(value) {
    _title = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }


}
