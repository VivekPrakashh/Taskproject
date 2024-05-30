class Taskmodal {
  Taskmodal({
    required this.title,
    required this.description,
      required this.date,
       required this.id,
  
  });
  late  String title;
  late  String description;
   late  String date;
    late  String id;
 
  
  Taskmodal.fromJson(Map<String, dynamic> json){
    title = json['title'] ?? '';
    description = json['description']?? '';
    date = json['date']?? '';
     id = json['id']?? '';
   
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['id'] = id;
  
    return data;
  }
}