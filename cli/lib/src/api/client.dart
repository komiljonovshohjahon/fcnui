import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'models/models.dart';

const String kBaseUrl = 'http://localhost:3000/api/';

typedef Result<T> = Either<DefaultError, T>;

class ApiClient {
  ApiClient() {
    initialize();
  }

  late final Dio dio;

  void initialize() {
    dio = Dio(BaseOptions(baseUrl: kBaseUrl));
  }

  Future<Result<DefaultResponse<List<ComponentFetchData>, ComponentFetchError>>>
      findComponents(List<String> componentNames) async {
    try {
      final response = await dio
          .post("ui/component", data: {"componentNames": componentNames});
      final bool success = response.data['success'];
      var defaultResponse =
          DefaultResponse<List<ComponentFetchData>, ComponentFetchError>(
              success: success);
      final ComponentFetchError error =
          ComponentFetchError.fromJson(response.data);
      defaultResponse = defaultResponse.copyWith(error: error);
      final List<ComponentFetchData> data =
          ((response.data['data'] as List?) ?? [])
              .map((e) => ComponentFetchData.fromJson(e))
              .toList();
      defaultResponse = defaultResponse.copyWith(data: data);
      return right(defaultResponse);
    } on DioException catch (e) {
      print('dio exception');
      return left(DefaultErrorImpl(message: "Server error: ${e.message}"));
    } catch (e, st) {
      print('exception');
      print(st);
      return left(DefaultErrorImpl(message: e.toString()));
    }
  }
}