import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:dot/secrets/secrets.dart' as secret;

Future<String?> gemini(String prompt) async {
  try {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: secret.apiKey,
    );
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return (response.text);
  } catch (e) {
    return e.toString();
  }
}
