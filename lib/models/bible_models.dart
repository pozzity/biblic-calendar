import 'bible_content.dart';

class BibleChapter {
  final int number;
  final List<BibleContent> content;
  final List<BibleFootnote> footnotes;

  BibleChapter({
    required this.number,
    required this.content,
    required this.footnotes,
  });

  factory BibleChapter.fromJson(Map<String, dynamic> json) => BibleChapter(
    number: json['chapter']?['number'] ?? 0,
    content: (json['chapter']?['content'] as List? ?? [])
        .map((v) => BibleContent.fromJson(v))
        .toList(),
    footnotes: (json['chapter']?['footnotes'] as List? ?? [])
        .map((v) => BibleFootnote.fromJson(v))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'number': number,
    'content': content.map((c) => c.toJson()).toList(),
    'footnotes': footnotes.map((f) => f.toJson()).toList(),
  };
}

class BibleFootnote {
  final int noteId;
  final String text;
  final String caller;
  final Map<String, dynamic>? reference;

  BibleFootnote({
    required this.noteId,
    required this.text,
    required this.caller,
    this.reference,
  });

  factory BibleFootnote.fromJson(Map<String, dynamic> json) => BibleFootnote(
    noteId: json['noteId'] ?? 0,
    text: json['text'] ?? '',
    caller: json['caller'] ?? '',
    reference: json['reference'],
  );

  Map<String, dynamic> toJson() => {
    'noteId': noteId,
    'text': text,
    'caller': caller,
    'reference': reference,
  };
}
