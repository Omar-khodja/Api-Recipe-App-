
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class Apiservice {
  Apiservice();
  Future<void> featchData()async {
    final url = Uri.parse("http://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata");
    try{
    final respons = await http.get(url);
    if(respons.statusCode == 200){
      log(respons.body);
    }
    }catch(e){
      Logger("error $e");
    }


  }

}