//
//  DataCalculator.swift
//  Lions Prey
//
//  Created by Edward Bender on 8/26/21.
//

import Foundation

class DataCalculator: ObservableObject {
    @Published var age: Double = 17
    @Published var noduleSize: Double = 0
    @Published var spiculated = false
    @Published var solid = false
    @Published var sizeDynamics: Double = 0
    @Published var smoker = false
    @Published var packYears: Double = 0
    @Published var cancerHistory = false
    @Published var followupCT = false {
        didSet {
            if !followupCT {
                sizeDynamics = 0
            }
        }
    }
    @Published var petAvailable = false {
        didSet {
            if !petAvailable {
                suvMax = 0
            }
        }
    }
    @Published var suvMax: Double = 0
    
    var constant: Double {
        petAvailable ? -6.245 : (followupCT ? -6.964 : -7.942)
    }
    
    var ageCoeff: Double {
        petAvailable ? 0.022 : (followupCT ? 0.028 : 0.026)
    }
    
    var noduleSizeCoeff: Double {
        petAvailable ? 0.056 : (followupCT ? 0.046 : 0.072)
    }
    
    var spiculationCoeff: Double {
        petAvailable ? -0.353 : (followupCT ? 0.818 : 1.205)
    }
    
    var solidCoeff: Double {
        petAvailable ? 0.841 : (followupCT ? 1.141 : 2.051)
    }
    
    var sizeDynamicsCoeff: Double {
        petAvailable ? 0.482 : (followupCT ? 0.556 : 0)
    }
    
    var smokingCoeff: Double {
        petAvailable ? 1.935 : (followupCT ? 2.163 : 2.778)
    }
    
    var packYearsCoeff: Double {
        petAvailable ? 0.014 : (followupCT ? 0.017 : 0.007)
    }
    
    var cancerCoeff: Double {
        petAvailable ? 0.535 : (followupCT ? 0.726 : 0.172)
    }
    
    var petCoeff: Double {
        0.438
    }
    
    var ageString: String {
        if age < 18 {
            return "<18"
        }
        if age > 85 {
            return ">85"
        }
        return "\(Int(age))"
    }
    
    var sizeString: String {
        if noduleSize < 4 {
            return "<4"
        }
        if noduleSize > 40 {
            return ">40"
        }
        return "\(Int(noduleSize))"
    }
    
    var packYearsString: String {
        if packYears > 100 {
            return ">100"
        }
        return "\(Int(packYears))"
    }
    
    var noduleSizeString: String {
        if noduleSize > 40 {
            return ">40"
        }
        return "\(Int(noduleSize))"
    }
    
    var sizeDynamicsString: String {
        if sizeDynamics > 30 {
            return ">30.0"
        }
        return "\(sizeDynamics.formatted(.number.precision(.fractionLength(1))))"
    }
    
    var suvMaxString: String {
        if suvMax > 30 {
            return ">30.0"
        }
        return "\(suvMax.formatted(.number.precision(.fractionLength(1))))"
    }
    
    func clearData() {
        age = 17
        noduleSize = 0
        spiculated = false
        solid = false
        sizeDynamics = 0
        smoker = false
        packYears = 0
        cancerHistory = false
        followupCT = false
        petAvailable = false
        suvMax = 0
    }
    
    var predictedMalignancy: String {
        let roundedAge = floor(age)
        let exponent = constant + roundedAge*ageCoeff + noduleSize.rounded(toPlaces: 5)*noduleSizeCoeff + spiculated.doubleValue()*spiculationCoeff + solid.doubleValue()*solidCoeff + sizeDynamics.rounded(toPlaces: 5)*sizeDynamicsCoeff + smoker.doubleValue()*smokingCoeff + packYears.rounded(toPlaces: 5)*packYearsCoeff + cancerHistory.doubleValue()*cancerCoeff + suvMax.rounded(toPlaces: 5)*petCoeff
        
        var calculation = exp(exponent.rounded(toPlaces: 5))/(1 + exp(exponent.rounded(toPlaces: 5)))
        
        if calculation < 0.005 {
            calculation = 0.0
        }
        
        let value = String(format: "%.1f %%", calculation * 100)
                
        return value
    }
}

extension Bool {
    func doubleValue() -> Double {
        self ? Double(1) : 0
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded()/divisor
    }
}
