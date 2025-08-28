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

  factory BibleChapter.fromJson(Map<String, dynamic> json) {
    final chapter = json['chapter'];
    final number = chapter is Map ? (chapter['number'] ?? 0) : 0;
    final rawContent = chapter is Map ? chapter['content'] : null;
    final contentList = rawContent is List
        ? rawContent.map((e) => BibleContent.fromDynamic(e)).toList()
        : <BibleContent>[];
    final rawFootnotes = chapter is Map ? chapter['footnotes'] : null;
    final footnotesList = rawFootnotes is List
        ? rawFootnotes
              .whereType<Map<String, dynamic>>()
              .map((v) => BibleFootnote.fromJson(v))
              .toList()
        : <BibleFootnote>[];
    return BibleChapter(
      number: number,
      content: contentList,
      footnotes: footnotesList,
    );
  }

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
    reference: json['reference'] is Map<String, dynamic>
        ? json['reference'] as Map<String, dynamic>
        : null,
  );

  Map<String, dynamic> toJson() => {
    'noteId': noteId,
    'text': text,
    'caller': caller,
    'reference': reference,
  };
}
