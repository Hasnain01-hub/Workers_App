class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/plumber.png',
      title: "Plumber",
    ),
    Category(
      imagePath: 'assets/images/electrician.png',
      title: 'Electrician',
    ),
    Category(
      imagePath: 'assets/images/builder.png',
      title: 'Mestri',
    ),
    Category(
      imagePath: 'assets/images/welder.png',
      title: 'Welder',
    ),

    Category(
      imagePath: 'assets/images/mechanic.png',
      title: 'Mechanic',
    ),
  ];
}
