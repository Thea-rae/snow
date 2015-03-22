void loadWeather() {
  runGetWeatherByAddressChoreo();//how I access the API
  getCurrentConditionsFromXML();//How I pull temp and snowtype
  getWindInfoFromXML();//How I get wind speed, direction and the feels like temp
  getAtmosphereDataFromXML();// how I get humidity and visability
  println(windChill, temperature, humidity, visability, conditionCode, pressure);//just for coding
}

void checkWeather() {
  if (minute()-tembooTimer>2) {
    tembooTimer=minute();
    runGetWeatherByAddressChoreo();//how I access the API
    getCurrentConditionsFromXML();//How I pull temp and snowtype
    getWindInfoFromXML();//How I get wind speed, direction and the feels like temp
    getAtmosphereDataFromXML();// how I get humidity and visability
    println(windChill, temperature, humidity, visability, conditionCode, pressure);//just for coding
  }
}

void runGetWeatherByAddressChoreo() {//give me ALL THE DATA
  GetWeatherByAddress getWeatherByAddressChoreo = new GetWeatherByAddress(session);
  getWeatherByAddressChoreo.setCredential("snow");
  getWeatherByAddressChoreo.setAddress(location);
  GetWeatherByAddressResultSet getWeatherByAddressResults = getWeatherByAddressChoreo.run();
  weatherResults = parseXML(getWeatherByAddressResults.getResponse());
}

void getCurrentConditionsFromXML() { //Okay some of the data?
  XML condition = weatherResults.getChild("channel/item/yweather:condition");
  temperature = condition.getInt("temp");
  conditionCode = condition.getInt("code");
}

void getWindInfoFromXML() {//and a little bit more
  XML wind =weatherResults.getChild("channel/yweather:wind");
  windChill =wind.getInt("chill");
  windDirection =wind.getInt("direction");
  windSpeed =wind.getInt("speed");

  if (windDirection >= 180) {
    direction = -1;
  } else {
    direction = 1;
  }
}

void getAtmosphereDataFromXML() {// mayyyyybe this will help? uh, thanks?
  XML atmosphere =weatherResults.getChild("channel/yweather:atmosphere");
  humidity =atmosphere.getInt("humidity");
  visability =atmosphere.getInt("visability");
  pressure =atmosphere.getFloat("pressure");
  rising =atmosphere.getInt("rising");
}
