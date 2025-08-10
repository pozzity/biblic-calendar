class BibleBook {
  final String id;
  final String translationId;
  final String name;
  final String commonName;
  final String title;
  final int order;
  final int numberOfChapters;
  final String firstChapterApiLink;
  final String lastChapterApiLink;
  final int totalNumberOfVerses;

  BibleBook({
    required this.id,
    required this.translationId,
    required this.name,
    required this.commonName,
    required this.title,
    required this.order,
    required this.numberOfChapters,
    required this.firstChapterApiLink,
    required this.lastChapterApiLink,
    required this.totalNumberOfVerses,
  });

  factory BibleBook.fromJson(Map<String, dynamic> json) => BibleBook(
    id: json['id'] ?? '',
    translationId: json['translationId'] ?? '',
    name: json['name'] ?? '',
    commonName: json['commonName'] ?? '',
    title: json['title'] ?? '',
    order: json['order'] ?? 0,
    numberOfChapters: json['numberOfChapters'] ?? 0,
    firstChapterApiLink: json['firstChapterApiLink'] ?? '',
    lastChapterApiLink: json['lastChapterApiLink'] ?? '',
    totalNumberOfVerses: json['totalNumberOfVerses'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'translationId': translationId,
    'name': name,
    'commonName': commonName,
    'title': title,
    'order': order,
    'numberOfChapters': numberOfChapters,
    'firstChapterApiLink': firstChapterApiLink,
    'lastChapterApiLink': lastChapterApiLink,
    'totalNumberOfVerses': totalNumberOfVerses,
  };
}
