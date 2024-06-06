class ModelClass{
  final String? email;
  final String? password;
  final String? uId;
  
  ModelClass({required this.email,required this.password,required this.uId});
  
  factory ModelClass.fromData(Map map){
    return ModelClass(email: map['E-mail'], password: map['password'], uId: map['uId']);
  }
}