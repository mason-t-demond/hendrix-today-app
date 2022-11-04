String title = '';
String description = '';
String event_date = '';
String begin_post = '';
String final_post = '';



class event_item{
  final String title;
  final String description;
  final String event_date;
  final String begin_post;
  final String final_post;
  
  event_item({required this.title, required this.description,
   required this.event_date, required this.begin_post, required this.final_post});
  
  date_split(){
    begin_post.split('/');
    final_post.split('/');

  }
}