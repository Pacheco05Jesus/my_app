import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

// ignore: use_function_type_syntax_for_parameters
on<HomeSearchPressed>((event, emit) async {
  emit(HomeLoadInProgress());

  final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  final token = 'sk-abc123TU_TOKEN'; // ← reemplaza con el que te dio el profe

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": event.query,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final respuestaIA = data['choices'][0]['message']['content'];
      emit(HomeLoadSuccess(respuestaIA));
    } else {
      emit(HomeLoadFailure('Error ${response.statusCode}: ${response.body}'));
    }
  } catch (e) {
    emit(HomeLoadFailure('Error de red: $e'));
  }
});
