import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping/src/models/regex_parser.dart';
import 'package:dart_ping/src/native_ping.dart';

/// Ping class used to instantiate a ping instance.
/// Spawns an OS ping process when the stream property is listened to
abstract class Ping {
  /// Creates an appropriate Ping instance for the detected platform
  factory Ping(

          /// Hostname, domain, or IP which you would like to ping
          String host,
          {

          /// How many times the host should be pinged before the process ends
          int? count,

          /// Delay between ping attempts
          double interval = 1.0,

          /// How long to wait for a ping to return before marking it as lost
          double timeout = 2.0,

          /// How many network hops the packet should travel before expiring
          int ttl = 255,

          /// IPv6 Mode (Not supported on Windows)
          bool ipv6 = false,

          /// Custom parser to interpret ping process output
          /// Useful for non-english based platforms
          RegexParser? parser}) =>
      getPing(host, count, interval, timeout, ttl, ipv6, parser);

  /// Parser used to interpret ping process output
  late RegexParser parser;

  /// The command that will be run on the host OS
  String get command;

  /// Stream of [PingData] which spawns a ping process on listen and
  /// kills it on cancellation. The stream closes when the process ends.
  ///
  /// Note that if you cancel the subscription, you will not receive
  /// the ping summary data. If you want to prematurely halt the process
  /// and still receive summary output, use the [stop] method.
  Stream<PingData> get stream;

  /// Kills ping process and closes stream.
  ///
  /// Using [stop] instead of subscription.cancel() allows the ping
  /// summary to output before the stream is closed. If you cancel
  /// your stream subscription, you will not receive summary output.
  Future<bool> stop();
}
