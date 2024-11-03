import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../resource/exceptions.dart';
import 'network_info.dart';

const _apiTimeout = Duration(seconds: 30);

@visibleForTesting
// ignore: public_member_api_docs
String domainUrl = const String.fromEnvironment('CAT_API_URL');

/// An abstract contract class for all api calls
///
/// This class makes api package switching easy,
/// all changes should be done here
abstract class ApiClient {
  /// A [Future] method for GET api calls
  Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  /// A [Future] method for POST api calls
  Future<Response> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  /// A [Future] method for PUT api calls
  Future<Response> put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });

  /// A [Future] method for DELETE api calls
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}

/// An implementation class for [ApiClient]
class ApiClientImpl implements ApiClient {
  /// This is the http client handler
  ///
  /// [Documentation](https://pub.dev/documentation/http/latest/)
  final Client client;

  /// This is the logger instance;
  final Logger logger;

  /// This is the [NetworkInfo] instance;
  final NetworkInfo networkInfo;

  /// Creates the implementation instance of [ApiClientImpl]
  ApiClientImpl({
    required this.client,
    required this.logger,
    required this.networkInfo,
  });

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final apiPath = path;
    try {
      logger.d(apiPath);
      if (query != null) logger.d(query);
      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');

      Uri uri = Uri.https(domainUrl, apiPath, query);

      final response =
          await client.get(uri, headers: headers).timeout(_apiTimeout);
      _handleResponseLog(response);
      return response;
    } catch (e) {
      _handleAPIError(e);
      rethrow;
    }
  }

  @override
  Future<Response> post({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final apiPath = path;
    try {
      logger.d(apiPath);
      if (body != null) logger.d(body);
      if (query != null) logger.d(query);

      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');

      Uri uri = Uri.https(domainUrl, apiPath, query);

      final response = await client
          .post(uri, body: jsonEncode(body), headers: headers)
          .timeout(_apiTimeout);
      _handleResponseLog(response);

      return response;
    } catch (e) {
      _handleAPIError(e);
      rethrow;
    }
  }

  @override
  Future<Response> put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final apiPath = path;

    try {
      logger.d(apiPath);
      if (body != null) logger.d(body);
      if (query != null) logger.d(query);

      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');

      Uri uri = Uri.https(domainUrl, apiPath, query);

      final response = await client
          .put(uri, body: jsonEncode(body), headers: headers)
          .timeout(_apiTimeout);
      _handleResponseLog(response);
      return response;
    } catch (e) {
      _handleAPIError(e);
      rethrow;
    }
  }

  @override
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final apiPath = path;
    try {
      logger.d(apiPath);

      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');
      Uri uri = Uri.https(domainUrl, apiPath);
      final response = await client
          .delete(uri, body: jsonEncode(body), headers: headers)
          .timeout(_apiTimeout);
      _handleResponseLog(response);
      return response;
    } catch (e) {
      _handleAPIError(e);
      rethrow;
    }
  }

  void _handleResponseLog(Response response) {
    if (response.statusCode != 200) {
      logger.e(response.body);
    } else {
      logger.i(response.body);
    }
  }

  void _handleAPIError(Object e) {
    if (e is TimeoutException) {
      throw const ServerException('Server did not respond');
    }
    logger.e(e);
  }
}
