class Community {
  String content;
  int likes;
  int dislikes;
  int BILL_NO;
  String BILL_NAME;
  String LINK_URL;
  String isChecked;

  Community({
    required this.BILL_NAME,
    required this.content,
    required this.LINK_URL,
    required this.likes,
    required this.dislikes,
    required this.BILL_NO,
    required this.isChecked,
  });
}