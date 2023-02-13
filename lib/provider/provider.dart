import 'package:flutter/cupertino.dart';

import '../screens/demo.dart';

class AppState extends ChangeNotifier {
 
  List<Employee> emp = [];
  var serial = [];
  var uids = [];
  var names = [];
  List<ImageDate> images = [];
  List<VideoDate> videos = [];

  getUsers(){
    for (int i = 0; i < uids.length; i++) {
      serial.add(i);
    }
    for (int i = 0; i < uids.length; i++) {
      emp.add(Employee(serial[i], names[i], uids[i]));
    }
    notifyListeners();
  }
   List<Employee> get dataList => emp;

  set dataList(List<Employee> dataList) {
    emp = dataList;
    notifyListeners();
  }

  String uid = "";
  String name = "";
  String username = "";
  String email = "";
  String phone = "";
  String address = "";

  String imgAddress = "";
}
class ImageDate{
  String?date;
  String?img;
  ImageDate(this.date,this.img);
}

class VideoDate{
  String?date;
  String?vid;
  VideoDate(this.date,this.vid);
}