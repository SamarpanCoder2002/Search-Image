import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:searchphoto/api/constant.dart';
import 'package:searchphoto/config/key_collection.dart';

class SearchApis {
  static onImageSearch(String query,
      {int pageIndex = 1, int totalItemPerPage = 15}) async {
    final url =
        '${API.baseUrl}/${API.searchUrl}?${API.queryParam}=$query&${API.perPageParam}=$totalItemPerPage&${API.pageParam}=$pageIndex';

    final _response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer ${dotenv.env[EnvFileKey.pixelsApiKey]}",
    });

    return json.decode(_response.body);


  }
}
