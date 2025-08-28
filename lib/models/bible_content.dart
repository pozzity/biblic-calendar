class BibleContent {
  final String type; // "verse", "heading", "line_break", etc.
  final int? number; // for verse
  final List<dynamic>? content; // for heading/verse: List<String|Map>

  BibleContent({required this.type, this.number, this.content});

  factory BibleContent.fromJson(Map<String, dynamic> json) => BibleContent(
    type: json['type'] ?? 'unknown',
    number: json['number'],
    content: json['content'] is List ? (json['content'] as List) : null,
  );

  /// Safe parser for any dynamic JSON element inside chapter content.
  factory BibleContent.fromDynamic(dynamic data) {
    if (data is Map<String, dynamic>) {
      return BibleContent.fromJson(data);
    }
    if (data is String) {
      // Treat plain strings as a line/heading chunk.
      return BibleContent(type: 'text', content: [data]);
    }
    return BibleContent(type: 'unknown');
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    if (number != null) 'number': number,
    if (content != null) 'content': content,
  };
}
