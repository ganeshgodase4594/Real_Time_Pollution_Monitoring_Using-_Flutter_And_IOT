import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late GenerativeModel _model;
  late ChatSession _chat;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void initializeModule () async{

    await dotenv.load(fileName: ".env");

  }
  Future<void> _initializeChat() async {
      initializeModule();
    await dotenv.load(fileName: ".env");

    _model = GenerativeModel(model: "gemini-pro", apiKey: dotenv.env['API_KEY']!);
    _chat = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    bool hasApiKey = dotenv.env['API_KEY'] != null && dotenv.env['API_KEY']!.isNotEmpty;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: hasApiKey
                  ? ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, idx) {
                        final content = _chat.history.toList()[idx];
                        final text =
                            content.parts.whereType<TextPart>().map<String>((e) => e.text).join('');
                        return MessageWidget(
                          text: text,
                          isFromUser: content.role == 'user',
                        );
                      },
                      itemCount: _chat.history.length,
                    )
                  : ListView(
                      children: const [
                        Text('hello how can i help you today!!!'),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        hintText: 'Enter a prompt...',
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        _sendChatMessage(value);
                      },
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 15,
                  ),
                  if (!_loading)
                    IconButton(
                      onPressed: () async {
                        _sendChatMessage(_textController.text);
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    )
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() => _loading = true);

    try {
      final response = await _chat.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        debugPrint('No response from API.');
        return;
      }
      setState(() => _loading = false);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _textController.clear();
      setState(() => _loading = false);
    }
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageWidget({
    Key? key,
    required this.text,
    required this.isFromUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: const EdgeInsets.only(bottom: 8),
            child: MarkdownBody(
              selectable: true,
              data: text,
            ),
          ),
        ),
      ],
    );
  }
}
