import 'package:client/shared/http/models/api_result.dart';

class PagingControllerResult<T> {
  final bool isLastPage;
  final List<T> items;

  PagingControllerResult({
    required this.items,
    required this.isLastPage,
  });
}

class PagingControllerManager {
  static void fetchItems<T>({
    required Future<ApiResult<List<T>>> future,
    required void Function(PagingControllerResult<T> result) callback,
    required void Function(String message) onError,
    required int limit,
  }) async {
    final apiResult = await future;

    if (!apiResult.isError) {
      final List<T> items = apiResult.get();
      final bool isLastPage = items.length < limit;

      return callback(
        PagingControllerResult<T>(
          items: items,
          isLastPage: isLastPage,
        ),
      );
    }

    return onError(
      apiResult.result.message,
    );
  }
}
