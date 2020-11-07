
List<String> create_search_key_words_list(String name) {
  List<String> result = new List(name.length);

  for (int i = 1; i <= name.length; i++) {
    result[i - 1] = (name.substring(0, i).toLowerCase());
  }

  return result;
}