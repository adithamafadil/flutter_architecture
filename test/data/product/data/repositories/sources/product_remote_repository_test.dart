import 'package:dio/dio.dart';
import 'package:flutter_architecture/constants/constants.dart';
import 'package:flutter_architecture/data/products/data/repositories/sources/remote/product_remote_repository.dart';
import 'package:flutter_architecture/state/remote/remote_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/data/dummy_data.dart';
import 'product_remote_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ProductRemoteRepository remoteRepository;
  late Dio dio;

  setUp(() {
    dio = MockDio();
    remoteRepository = ProductRemoteRepository(dio);
  });

  group('ProductRemoteRepository -', () {
    test('''Success case\t
    Given network connection
    When access ProductRemoteRepository to get products
    Then it returns RemoteStateSuccess with data
    ''', () async {
      when(dio.get(MyConstants.endpoint.product)).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(path: MyConstants.endpoint.product),
            data: DummyData.product.mapDummyData,
            statusCode: 200,
          ),
        ),
      );

      final result = await remoteRepository.getProducts();

      verify(dio.get(MyConstants.endpoint.product));

      expect(result, isA<RemoteStateSuccess>());

      result.when(
        success: (data) {
          expect(data.length, DummyData.product.dtoDummyData.length);
          expect(data.first.id, DummyData.product.dtoDummyData.first.id);
        },
        error: (_, __, ___, ____, _____) => null,
      );
    });

    test('''Error no connection case\t
    Given no network connection
    When access ProductRemoteRepository to get products
    Then it throws a RemoteStateError
    ''', () async {
      when(dio.get(MyConstants.endpoint.product)).thenThrow(
        DioError(
          response: Response(
            requestOptions: RequestOptions(path: MyConstants.endpoint.product),
            statusCode: 600,
            statusMessage: 'No Connection found',
          ),
          requestOptions: RequestOptions(path: MyConstants.endpoint.product),
        ),
      );

      final result = await remoteRepository.getProducts();

      verify(dio.get(MyConstants.endpoint.product));

      expect(result, isA<RemoteStateError>());

      result.when(
        success: (data) => null,
        error: (message, data, statusCode, exception, stackTrace) {
          expect(message, ': No Connection found');
          expect(statusCode, 600);
          expect(data, null);
        },
      );
    });
  });
}
