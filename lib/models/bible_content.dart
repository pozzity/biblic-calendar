class BibleContent {
  final String type; // "verse", "heading", "line_break"
  final int? number; // for verse
  final List<dynamic>? content; // for heading/verse: List<String|Map>

  BibleContent({required this.type, this.number, this.content});

  factory BibleContent.fromJson(Map<String, dynamic> json) => BibleContent(
    type: json['type'],
    number: json['number'],
    content: json['content'] as List?,
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    if (number != null) 'number': number,
    if (content != null) 'content': content,
  };
}
