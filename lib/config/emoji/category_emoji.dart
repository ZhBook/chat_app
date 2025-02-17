import 'package:chat_app/config/emoji/emoji.dart';
import 'package:chat_app/config/emoji/emoji_picker_flutter.dart';

/// Container for Category and their emoji
class CategoryEmoji {
  /// Constructor
  CategoryEmoji(this.category, this.emoji);

  /// Category instance
  final Category category;

  /// List of emoji of this category
  List<Emoji> emoji;
}
