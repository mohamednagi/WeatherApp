
import UIKit

class ViewController: UIViewController , WeatherServiceDelegate{
    
    @IBOutlet weak var CityTF: UITextField!
    @IBOutlet weak var Weatherlbl: UILabel!
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var humaditylbl: UILabel!
    @IBOutlet weak var windlbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyImage.layer.cornerRadius = 40
        MyImage.clipsToBounds = true
        WeatherService.delegate = self
    }
    
    @IBAction func GetWeatherButton(_ sender: Any) {
        DispatchQueue.main.async {
            if self.CityTF.text == "" {
           self.CreatAlertCon()
            }
            WeatherService.GetWeather(city: self.CityTF.text!)
        }
    }
    func CreatAlertCon(){
        let alert = UIAlertController(title: "City", message: "Enter Your City", preferredStyle: .alert)
        let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            let TF = alert.textFields![0]
            let city = TF.text!
            WeatherService.GetWeather(city: city)
        }
        alert.addAction(Cancel)
        alert.addAction(ok)
        alert.addTextField { (TF:UITextField) in
            TF.placeholder = "City Name"
        }
        present(alert, animated: true, completion: nil)
    }
    
    func Error(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func SetWeather(weather : Weather) {
        print("City Name : \(weather.CityName) , Des : \(weather.Des) , Temp : \(weather.Temp)")
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let f = formatter.string(from: NSNumber(value:weather.Temp - 273.15))
        Weatherlbl.text = "\(Double(f!)!)"
        humaditylbl.text = "\(weather.humedity)"
        windlbl.text = "\(weather.wind)"
    }

    
}

