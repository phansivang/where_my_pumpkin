import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// An abstract class for network related information
///
/// This class helps by separating third party network library and our code.
abstract class NetworkInfo {
  /// A get method that tells whether user is connected
  Future<bool> get isConnected;

  /// A method contract for getting the connection stream
  Future<Stream<InternetStatus>> connect();

  /// A method contract for stream disconnections
  Future<void> disconnect();
}

/// An implementation class for network info contract
class NetworkInfoImpl implements NetworkInfo {
  /// External package for network handling
  ///
  /// [pub.dev](https://pub.dev/packages/internet_connection_checker_plus)
  final InternetConnection internetConnectionChecker;
  @visibleForTesting

  /// This is the internet connection stream
  Stream<InternetStatus>? internetStream;

  /// Creates the implementation instance of [NetworkInfo]
  NetworkInfoImpl(this.internetConnectionChecker);
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasInternetAccess;

  @override
  Future<Stream<InternetStatus>> connect() async {
    internetStream ??= internetConnectionChecker.onStatusChange;
    return internetStream!;
  }

  @override
  Future<void> disconnect() async {
    if (internetStream != null) internetStream = null;
  }
}
