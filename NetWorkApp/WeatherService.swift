import Foundation

protocol WeatherServiceDelegate {
    func SetWeather(weather : Weather)
    func Error (message : String)
}

class WeatherService {
    
  static  var delegate : WeatherServiceDelegate?
  
    static func GetWeather(city:String){
        
        let Sstring = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7ae9e49c738ef80279e2b0fe3958be22"
        let path = URL(string: Sstring)
        let request = URLRequest(url: path!)
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            
         if let httpresponse = response as? HTTPURLResponse{
                print("***********")
                print(httpresponse.statusCode)
                print("***********")
            }
            do{
                 if error == nil {
                 if let mydata = data{
                    let json = try JSON(data: mydata)
                    var status = 0
                    if let cod = json["cod"].int {
                        status = cod
                    }else if let cod2 = json["cod"].string {
                     status = Int(cod2)!
                    }
                    if status == 200 {
                        let lat = json["coord"]["lat"].double
                        let lon = json["coord"]["lon"].double
                        let temp = json["main"]["temp"].double
                        let name = json["name"].string
                        let des = json["weather"][0]["description"].string
                        let wind = json["wind"]["speed"].double
                        let humedity = json["main"]["humidity"].double
                        let weather = Weather(CityName: name!, Temp: temp!, Des: des!, humedity : humedity!, wind : wind!)
                        if delegate != nil {
                            DispatchQueue.main.async {
                                self.delegate?.SetWeather(weather: weather)
                            }
                        }
                      //  print("Lon : \(lon!) , Lat : \(lat!) , Temp : \(temp!) , Name : \(name!) , Description : \(des!)")
                    }else if status == 404 {
                        if self.delegate != nil {
                            DispatchQueue.main.async {
                                self.delegate?.Error(message: "City NotFound")
                            }
                        }
                    }else {
                        if self.delegate != nil {
                            DispatchQueue.main.async {
                                self.delegate?.Error(message: "SomeThing Went Wrong")
                            }
                    }
                    }
                    }
                    }
                }catch {
                    print("Error")
                }
            }.resume()
    }
}
