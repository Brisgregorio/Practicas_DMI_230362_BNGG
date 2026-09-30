import 'dart:math';

import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class GetYesNoAnswer {
  final Dio _dio = Dio();
  final Random _random = Random();

  Future<Message> getAnswer() async {
    final number = _random.nextInt(100);

    late final String answerForApi;
    late final String answerForChat;

    if (number < 40) {
      answerForApi = 'yes';
      answerForChat = 'Sí';
    } else if (number < 80) {
      answerForApi = 'no';
      answerForChat = 'No';
    } else {
      answerForApi = 'maybe';
      answerForChat = 'Tal vez';
    }

    final response = await _dio.get(
      'https://yesno.wtf/api',
      queryParameters: {'force': answerForApi},
    );

    return Message(
      text: answerForChat,
      fromWho: FromWho.hers,
      imageUrl: response.data['image'] as String,
    );
  }
}
