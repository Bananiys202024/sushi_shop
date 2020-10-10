class Constants {
  static final String title_of_top_menu = "atomic sushi";
  static final String fish_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum pellentesque consequat erat, eu congue leo tincidunt pretium. ";
  static final String text_for_comment_field = "you can write here about your speciall desires";

  static const  String TWILIO_SMS_API_BASE_URL = 'https://api.twilio.com/2010-04-01';

  //use as name of images in drawer;
  static var categories = [
    'new',
    'packs and combos',
    'pizza',
    'roll',
    'sushi',
    'favorites',
  ];

  static get_title_of_top_menu() {
    return title_of_top_menu;
  }

  static get_fish_text() {
    return fish_text;
  }

  static get_comment_text() {
    return text_for_comment_field;
  }

  static get_categories()
  {
    return categories;
  }
}