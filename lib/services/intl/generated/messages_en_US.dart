// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'en': MessageLookupByLibrary.simpleMessage('English'),
        'fr': MessageLookupByLibrary.simpleMessage('French'),
        'ignore': MessageLookupByLibrary.simpleMessage('Ignore'),
        'language': MessageLookupByLibrary.simpleMessage('Language'),
        'module_bible_content': MessageLookupByLibrary.simpleMessage(
            'In the «translations» menu, you have the possibility of downloading a translation or several translations according to your preferences. You also have the possibility of making a filter: it is fast and efficient 😇'),
        'module_bible_header': MessageLookupByLibrary.simpleMessage(
            'Free access to several translations!'),
        'module_calendar_content': MessageLookupByLibrary.simpleMessage(
            'The application offers daily verses from your community that you can read and share with your loved ones.'),
        'module_calendar_header':
            MessageLookupByLibrary.simpleMessage('Daily reading'),
        'module_welcome_content': MessageLookupByLibrary.simpleMessage(
            'This application has been designed to allow \n \t- Any believing community to create and share publications with their followers \n \t- Any family to improve awareness of speech \n \t- Any person to better analyze and share the St scriptures'),
        'module_welcome_header':
            MessageLookupByLibrary.simpleMessage('Welcome!'),
        'save': MessageLookupByLibrary.simpleMessage('Save'),
        'select_preferred_lang': MessageLookupByLibrary.simpleMessage(
            'Please select your preferred language'),
        'start': MessageLookupByLibrary.simpleMessage('Start')
      };
}
