import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

class GraphQLClientService {
  static GraphQLClient? _publicClient;
  static GraphQLClient? _userClient;
  static final SecureStorage _secureStorage = SecureStorage();

  static GraphQLClient get publicClient {
    _publicClient ??= GraphQLClient(
      link: _createHttpLink(ApiConstants.publicGraphQLEndpoint),
      cache: GraphQLCache(store: InMemoryStore()),
    );
    return _publicClient!;
  }

  static Future<GraphQLClient> get userClient async {
    final token = await _secureStorage.getAccessToken();

    _userClient = GraphQLClient(
      link: AuthLink(
        getToken: () async => token != null ? 'Bearer $token' : null,
      ).concat(_createHttpLink(ApiConstants.userGraphQLEndpoint)),
      cache: GraphQLCache(store: InMemoryStore()),
    );

    return _userClient!;
  }

  static HttpLink _createHttpLink(String uri) {
    return HttpLink(
      uri,
      defaultHeaders: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      httpClient: null, // Use default HTTP client
    );
  }

  static void resetClients() {
    _publicClient = null;
    _userClient = null;
  }

  static Future<QueryResult> executeQuery({
    required String query,
    Map<String, dynamic>? variables,
    bool requiresAuth = false,
  }) async {
    final operationName = _extractOperationName(query);

    try {
      final client = requiresAuth ? await userClient : publicClient;

      final result = await client.query(
        QueryOptions(
          document: gql(query),
          variables: variables ?? {},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (kDebugMode && ApiConstants.enableStatusLogging) {
        _logStatus(
          operation: 'Query',
          operationName: operationName,
          result: result,
        );
      }

      return result;
    } catch (e) {
      if (kDebugMode && ApiConstants.enableErrorLogging) {
        _logError(
          operation: 'Query',
          operationName: operationName,
          error: e,
        );
      }
      rethrow;
    }
  }

  static Future<QueryResult> executeMutation({
    required String mutation,
    Map<String, dynamic>? variables,
    bool requiresAuth = false,
  }) async {
    final operationName = _extractOperationName(mutation);

    try {
      final client = requiresAuth ? await userClient : publicClient;

      final result = await client.mutate(
        MutationOptions(
          document: gql(mutation),
          variables: variables ?? {},
        ),
      );

      if (kDebugMode && ApiConstants.enableStatusLogging) {
        _logStatus(
          operation: 'Mutation',
          operationName: operationName,
          result: result,
        );
      }

      return result;
    } catch (e) {
      if (kDebugMode && ApiConstants.enableErrorLogging) {
        _logError(
          operation: 'Mutation',
          operationName: operationName,
          error: e,
        );
      }
      rethrow;
    }
  }

  // Extract operation name from GraphQL query/mutation
  static String _extractOperationName(String operation) {
    final regex =
        RegExp(r'(?:query|mutation)\s+(\w+)|(?:query|mutation)\s*\{?\s*(\w+)');
    final match = regex.firstMatch(operation);
    if (match != null) {
      return match.group(1) ?? match.group(2) ?? 'Unknown';
    }

    // Try to extract from the first field
    final fieldRegex = RegExp(r'\{\s*(\w+)');
    final fieldMatch = fieldRegex.firstMatch(operation);
    return fieldMatch?.group(1) ?? 'Unknown';
  }

  // Simple status logging
  static void _logStatus({
    required String operation,
    required String operationName,
    required QueryResult result,
  }) {
    final timestamp = DateTime.now().toIso8601String();

    if (result.hasException) {
      debugPrint('❌ [$timestamp] $operation $operationName - Failed');
      if (result.exception?.graphqlErrors.isNotEmpty == true) {
        for (final error in result.exception!.graphqlErrors) {
          debugPrint('   GraphQL Error: ${error.message}');
        }
      }
      if (result.exception?.linkException != null) {
        debugPrint(
            '   Network Error: ${result.exception!.linkException.runtimeType}');
      }
    } else {
      debugPrint('✅ [$timestamp] $operation $operationName - Success');
    }
  }

  // Simple error logging
  static void _logError({
    required String operation,
    required String operationName,
    required dynamic error,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    debugPrint(
        '💥 [$timestamp] $operation $operationName - Error: ${error.runtimeType}');

    // Log error type without sensitive information
    if (error is Exception) {
      final errorString = error.toString();
      if (errorString.contains('TimeoutException')) {
        debugPrint('⏱️ Timeout Error');
      } else if (errorString.contains('SocketException')) {
        debugPrint('🌐 Network Error');
      } else {
        debugPrint('🔥 Error: $errorString');
      }
    }
  }
}
