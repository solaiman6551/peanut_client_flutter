class AssetsProvider{

  static String imagePath(String name, {String type = 'png'}){
    return 'assets/image_files/$name.$type';
  }

  static String svgPath(String name){
    return 'assets/svg_files/$name.svg';
  }

  static String lottiePath(String name){
    return 'assets/lottie_files/$name.json';
  }

  static String gifPath(String name){
    return 'assets/gif_files/$name.gif';
  }

  static String jsonPath(String name){
    return 'assets/json_files/$name.json';
  }
}
