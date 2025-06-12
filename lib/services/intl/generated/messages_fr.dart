// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.
// @dart=2.12
// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'fr';

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'english': MessageLookupByLibrary.simpleMessage('Anglais'),
        'french': MessageLookupByLibrary.simpleMessage('Français'),
        'ignore': MessageLookupByLibrary.simpleMessage('Ignorer'),
        'language': MessageLookupByLibrary.simpleMessage('Langue'),
        'module_bible_content': MessageLookupByLibrary.simpleMessage(
            'Dans le menu «traductions», vous avez la possibilité de télécharger une traduction ou plusieurs traductions selon vos préférences. Vous avez également la possibilité de réaliser un filtre: il est rapide et efficace 😇'),
        'module_bible_header': MessageLookupByLibrary.simpleMessage(
            'Un accès libre et gratuit a plusieur traduction!'),
        'module_calendar_content': MessageLookupByLibrary.simpleMessage(
            'L\'application propose des versets quotidiens de votre communauté que vous pouvez lire et partager avec vos proches.'),
        'module_calendar_header':
            MessageLookupByLibrary.simpleMessage('Lecture quotidienne'),
        'module_welcome_content': MessageLookupByLibrary.simpleMessage(
            'Cette application a été conçue pour permettre à \n \t- Toute communauté croyante de créer et de partager des publications avec ses abonnés \n \t- Toute famille pour améliorer la prise de conscience de la parole \n \t- Toute personne pour mieux analyser et partager les écritures St'),
        'module_welcome_header':
            MessageLookupByLibrary.simpleMessage('Bienvenue!'),
        'save': MessageLookupByLibrary.simpleMessage('Enregistrer'),
        'select_preferred_lang': MessageLookupByLibrary.simpleMessage(
            'Veuillez sélectionner votre langue préférée'),
        'start': MessageLookupByLibrary.simpleMessage('Commencer')
      };
}
