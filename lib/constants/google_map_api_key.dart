const GOOGLE_API_KEY = 'AIzaSyCbfO186hgOZdPM64077xecdmQdXkZNNJY';

class DirectionHelper{
  static String generateLocationPreviewImage({required double latitude, required double longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

}