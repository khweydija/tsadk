// ignore_for_file: file_names

class Don {
  final String? nom;
  final String? prenom;
  final String? groupseng;
  final String? contact;
  final int? age;
  final double? lat;
  final double? long;

  Don({this.nom, this.prenom, this.groupseng, this.contact, this.age, this.lat, this.long});
  static Don fromJson(Map<String,dynamic> json) => Don(
    nom: json['nom'],
    prenom: json['prenom'],
    groupseng: json['groupseng'],
    contact: json['contact'],
    age: json['age'],
    lat: json['lat'],
    long: json['age'],
  ); 

  // "nom": nom,
  //       "prenom": prenom,
  //       "groupseng": groupseng,
  //       "contact": contact,
  //       "age": age,
  //       "lat": position.altitude,
  //       "long": position.longitude
}
