import 'package:meta/meta.dart';




class DoctorField {
  static final String Prefix = 'Prefix';
}

class Doctoruser {
  final String? idUser;
  final String ?name;
  final String ?urlAvatar;
  final String ?prefix;

  const Doctoruser({
    this.idUser,
    @required this.name,
    @required this.urlAvatar,
    @required this.prefix, Prefix,
  });

  Doctoruser copyWith({
    String? idUser,
    String ?name,
    String ?urlAvatar,
    String ?prefix,
  }) =>
      Doctoruser(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        // urlAvatar: urlAvatar ?? this.urlAvatar,
        Prefix: prefix ?? this.prefix,
      );

  static Doctoruser fromJson(Map<String, dynamic> json) => Doctoruser(
    idUser: json['idUser'],
    name: json['FirstName'],
    //urlAvatar: json['urlAvatar'],
    Prefix:json['Prefix'],
  );

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'FirstName': name,
    //'urlAvatar': urlAvatar,
    'Prefix': prefix,
  };
}
