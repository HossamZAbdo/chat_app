
class Category {
  static String moviesTd = 'movies';
  static String musicTd = 'music';
  static String sportsTd = 'sports';

  String id;
  late String title;
  late String image;

  Category({required this.id, required this.title, required this.image});

  Category.fromId({required this.id}) {

    if (id == moviesTd) {
      title = 'movies';
      image = 'assets/images/movies.png';
    } else if (id == musicTd) {
      title = 'music';
      image = 'assets/images/music.png';
    } else if (id == sportsTd) {
      title = 'sports';
      image = 'assets/images/sports.png';
    }
  }

  static List<Category> getAllCategories() {
    return [
      Category.fromId(id: moviesTd),
      Category.fromId(id: musicTd),
      Category.fromId(id: sportsTd),
    ];
  }
}

// image = 'assets/images/$id.png';
// title = '$id';