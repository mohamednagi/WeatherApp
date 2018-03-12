//
//  Weather.swift
//  NetWorkApp
//
//  Created by Sierra on 2/24/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import Foundation

struct Weather {
    var CityName : String
    var Temp : Double
    var Des : String
    var humedity : Double
    var wind : Double
    
    init(CityName : String , Temp : Double , Des : String , humedity : Double , wind : Double) {
        self.CityName = CityName
        self.Temp = Temp
        self.Des = Des
        self.humedity = humedity
        self.wind = wind
    }
}
