class Youtube {
  List items;

  Youtube({
    required this.items,
  });

  factory Youtube.formMap({required Map data}) {
    return Youtube(
      items: data['items'],
    );
  }
}
