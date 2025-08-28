class BibleVersion {
  final String id;
  final String name;
  final String website;
  final String licenseUrl;
  final String shortName;
  final String englishName;
  final String language;
  final String textDirection;
  final List<String> availableFormats;
  final String listOfBooksApiLink;
  final int numberOfBooks;
  final int totalNumberOfChapters;
  final int totalNumberOfVerses;
  final String languageName;
  final String languageEnglishName;
  final bool isDownloaded;
  final bool isDefault;

  BibleVersion({
    required this.id,
    required this.name,
    required this.website,
    required this.licenseUrl,
    required this.shortName,
    required this.englishName,
    required this.language,
    required this.textDirection,
    required this.availableFormats,
    required this.listOfBooksApiLink,
    required this.numberOfBooks,
    required this.totalNumberOfChapters,
    required this.totalNumberOfVerses,
    required this.languageName,
    required this.languageEnglishName,
    this.isDownloaded = false,
    this.isDefault = false,
  });

  factory BibleVersion.fromJson(Map<String, dynamic> json) => BibleVersion(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    website: json['website'] ?? '',
    licenseUrl: json['licenseUrl'] ?? '',
    shortName: json['shortName'] ?? '',
    englishName: json['englishName'] ?? '',
    language: json['language'] ?? '',
    textDirection: json['textDirection'] ?? '',
    availableFormats:
        (json['availableFormats'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
    listOfBooksApiLink: json['listOfBooksApiLink'] ?? '',
    numberOfBooks: json['numberOfBooks'] ?? 0,
    totalNumberOfChapters: json['totalNumberOfChapters'] ?? 0,
    totalNumberOfVerses: json['totalNumberOfVerses'] ?? 0,
    languageName: json['languageName'] ?? '',
    languageEnglishName: json['languageEnglishName'] ?? '',
    isDownloaded: json['isDownloaded'] ?? false,
    isDefault: json['isDefault'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'website': website,
    'licenseUrl': licenseUrl,
    'shortName': shortName,
    'englishName': englishName,
    'language': language,
    'textDirection': textDirection,
    'availableFormats': availableFormats,
    'listOfBooksApiLink': listOfBooksApiLink,
    'numberOfBooks': numberOfBooks,
    'totalNumberOfChapters': totalNumberOfChapters,
    'totalNumberOfVerses': totalNumberOfVerses,
    'languageName': languageName,
    'languageEnglishName': languageEnglishName,
    'isDownloaded': isDownloaded,
    'isDefault': isDefault,
  };

  BibleVersion copyWith({bool? isDownloaded, bool? isDefault}) => BibleVersion(
    id: id,
    name: name,
    website: website,
    licenseUrl: licenseUrl,
    shortName: shortName,
    englishName: englishName,
    language: language,
    textDirection: textDirection,
    availableFormats: availableFormats,
    listOfBooksApiLink: listOfBooksApiLink,
    numberOfBooks: numberOfBooks,
    totalNumberOfChapters: totalNumberOfChapters,
    totalNumberOfVerses: totalNumberOfVerses,
    languageName: languageName,
    languageEnglishName: languageEnglishName,
    isDownloaded: isDownloaded ?? this.isDownloaded,
    isDefault: isDefault ?? this.isDefault,
  );
}
