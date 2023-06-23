import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:dio/dio.dart';
import '../../View/Reusable/text.dart';
import '../Repo/auth_bloc.dart';
import '../Repo/auth_event.dart';
import 'end_points.dart';

class DioHelper {
  final Dio dio = Dio();
  final Dio refreshDio = Dio();
  AuthBloc authBloc;
  bool isRefreshed = false;

  DioHelper(this.authBloc) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['Authorization'] = 'Bearer $token';
      handler.next(options);
    }, onError: (error, handler) async {
      if (isRefreshed == false) {
        if (error.response?.statusCode == 401) {
          await refreshAccessToken();
          return handler.resolve(await _retry(error.requestOptions));
        } else if (error.response?.statusCode == null ||
            error.response?.statusCode == 503) {
          authBloc.add(ServerDownEvent());
        } else {
          authBloc.add(ServerDownEvent());
        }
        return handler.next(error);
      }
    }));
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
        CacheHelper.saveData(
            key: 'token', value: response.data['access_token']);
        token = CacheHelper.getData(key: 'token');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == null || e.response!.statusCode == 503) {
          authBloc.add(ServerDownEvent());
        } else if (e.response!.statusCode == 401 &&
            e.response!.data['error'] == 'token_expired') {
          authBloc.add(ExpiredTokenEvent());
          isRefreshed = true;
        } else if (e.response!.statusCode == 401 &&
            e.response!.data['error'] == 'token_revoked') {
          authBloc.add(ExpiredTokenEvent());
        } else {
          authBloc.add(ServerDownEvent());
        }
      } else {
        authBloc.add(ServerDownEvent());
      }
    }
  }
}
