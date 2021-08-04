Uri getUrl(String endpoint) {
  //for prod
  // return Uri.https('char-app-backend.herokuapp.com', endpoint);
  // for dev
  return Uri.http('10.0.2.2:5000', endpoint);
}
