class Authority{
  String code;
  String name;
  Authority({required this.name, required this.code});
  factory Authority.fromJson(Map<String, dynamic> json){
    return Authority(
      name: json['name'],
      code: json['code']
    );
  }
}