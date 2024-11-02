class UnboardingContent {
  String images;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.images, required this.title});
}

List<UnboardingContent> contens = [
  UnboardingContent(
      description: "Pick your food from our menu\nMore than 35 times",
      images: "assets/images/screen1.png",
      title: "Select from Our\nBest Menu"),
  UnboardingContent(
      description:
          "You can pay cash on delivery and \nCard payment is available",
      images: "assets/images/screen2.png",
      title: "Easy and Online Payment"),
  UnboardingContent(
      description: "Deliver your food at your\nDoorstep",
      images: "assets/images/screen3.png",
      title: "Quick Delivery at \nYour Doorstep ")
];
