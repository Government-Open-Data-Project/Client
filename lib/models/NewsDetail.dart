class NewsDetail {
  DateTime reg_date; //올리는 날짜
  String link_url; //기사 링크
  String comp_main_title; // 기사 제목
  String comp_content; // 기사 내용

  NewsDetail({
    required this.reg_date,
    required this.link_url,
    required this.comp_main_title,
    required this.comp_content,
  });
}