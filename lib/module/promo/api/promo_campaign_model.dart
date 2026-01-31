class PromoCampaign {
  final String title;
  final String imageUrl;
  final String link;

  PromoCampaign({required this.title, required this.imageUrl, required this.link});

  factory PromoCampaign.fromXml(Map<String, dynamic> data) {
    String rawUrl = data['ImageUrl'] ?? '';
    String fixedUrl = rawUrl.replaceAll('forex-images.instaforex.com', 'forex-images.ifxdb.com');

    return PromoCampaign(
      title: data['Title'] ?? '',
      imageUrl: fixedUrl,
      link: data['Link'] ?? '',
    );
  }
}