import 'package:image_picker/image_picker.dart';

class AddArticleArguments {
  String title;
  String description;
  String category;
  PickedFile headerImage;

  AddArticleArguments(
      this.title, this.description, this.category, this.headerImage);
}
