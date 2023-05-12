//
//  Int+Extention.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 11.05.2023.
//

import Foundation
extension Int{
    
    func minuteFormat()->String{
        let minutes = (self / 60) % 60
        let seconds = self % 60

        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
}
