import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:dio/dio.dart';
import '../../View/Reusable/text.dart';
import 'end_points.dart';

class DioHelper {
  final Dio dio = Dio();
  final Dio refreshDio = Dio();
  int errorStatusCode = 0;
  String? accessToken;

  DioHelper() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
      onError: (error, handler) async {
        // If the response status code is 401, refresh the access token and retry the request
        if (error.response?.statusCode == 401) {
          await refreshAccessToken();
          return handler.resolve(await _retry(error.requestOptions));
        }else if(error.response?.statusCode == null){
          errorStatusCode=-1;
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<Response> get(String url) async {
    return dio.get(url);
  }

  Future<Response> post(String url, {dynamic data}) async {
    return dio.post(url, data: data);
  }

  Future<Response> put(String url, {required dynamic data}) async {
    return dio.put(url, data: data);
  }

  Future<Response> delete(String url, {dynamic data}) async {
    return dio.delete(url);
  }

  Future<void> refreshAccessToken() async {
    refreshDio.options.headers['Authorization'] = 'Bearer $refreshToken';
    try {
      Response response = await refreshDio.post('$base/$refresh',
          options: Options(headers: {'Authorization': 'Bearer $refreshToken'}));
      if (response.statusCode == 200) {
        token = response.data['access_token'];
        CacheHelper.saveData(key: 'token', value: accessToken);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == null) {
          errorStatusCode = -1;
        } else if (e.response!.statusCode == 401 &&
            e.response!.data['error'] == 'token_expired') {
          errorStatusCode = e.response!.statusCode!;
        } else if (e.response!.statusCode == 401 &&
            e.response!.data['error'] == 'token_revoked') {
          errorStatusCode = 402;
        }else{
          errorStatusCode=400;
        }
      }
    }
  }
}
