//
//  ThermalSystem.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/16/23.
//

import Foundation
class ThermalSystem {
    
    // Singleton
    static let shared = ThermalSystem()

    // Global Parameters
    /// User established and associated values
    var collectorType: String?
    var collectorEfficiency: Double?
    var collectorHeatLossCoefficient: Int?
    var collectorAreaRatio: Double?
    var collectorTilt: String?
    var collectorOrientation: String?
    var annualRadiation: Int?
    var collectorWidth: Double?
    var collectorHeight: Double?
    var collectorArea: Double?
    
    func setCollectorType(with name: String) {
        collectorType = name
        print(collectorType!)
    }
    
    func setCollectorTilt(with angle: String) {
        collectorTilt = angle
        print(collectorTilt!)
    }
    
    func setCollectorOrientation(with direction: String) {
        collectorOrientation = direction
        print(collectorOrientation!)
    }
    
// mutating func updateSystemParameters(
    
    //    // if making a collectorInstallation model:
    //    /// if I did it this way, the assigning function would look look like if "South", ThermalSystem.solarInput = horizontal.southRadiation
    //    struct collectorInstallation {
    //        let tilt: String
    //        let southRadiation: Int
    //        let seswRadation: Int
    //        let ewRadation: Int
    //        let nenwRadation: Int
    //        let northRadiation: Int
    //    }
    //
    // Notes to pick up tomorrow: Do you want to have user able to select specific month, gauge the output based on the available solar radiation that month based on selected collector tilt, and show an heat transfer results for that month? Or should we have user enter their location, find the kWh/m^2 and give the average from the year for a simulation length of a month duration? Keep it simple.
    // Two dimensional arrays to represent the table data of collector factors
    // Create whole simulation first with placeholder values and then replace with refined calculations
    
}

/*
 STC (standard test conditions):
 radiation = 1000 W/m^2
 cellTemp = 25 deg C
 windSpeed = 1m/s
 airMass = 1.5
 */
