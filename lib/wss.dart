import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


final runsProvider = StreamProvider((ref) {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:8080'),
  );

  ref.onDispose(() => channel.sink.close());

  return channel.stream;
});
