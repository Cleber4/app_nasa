class NasaApiEndpoints {
  static String apod(String apiKey, String date) =>
      "https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$date";
}
