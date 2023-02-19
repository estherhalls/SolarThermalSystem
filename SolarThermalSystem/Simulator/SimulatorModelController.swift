//
//  SimulatorModelController.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/18/23.
//

import Foundation
class SimulatorModelController {
    
    // MARK: - Singleton
    static let shared = SimulatorModelController()
    
    // MARK: - Properties
    // User established and associated values
    var collectorType: String?
    var collectorEfficiency: Double?
    var collectorHeatLossCoefficient: Int?
    var collectorTilt: String?
    var collectorOrientation: String?
    var collectorWidth: Double?
    var collectorHeight: Double?
    var collectorAreaRatio: Double?
    var annualRadiation: Int?
    var solarInput: Int? // result of solar contribution formula
    var overshadingFactor: Double? // Factor associated with user assigned shading quantity
    var tankVolume: Double?
    
    // Computed Properties that will be used as terms for expressions in solar contribution and heat transfer formulas
    var collectorApertureArea: Double? // collectorHeight * collectorWidth * ratio
    var collectorPerformanceFactor: Double? // heat loss coefficient/collector efficiency determined by collector type (ratio)-> if ratio < 20 = 0.97 - 0.0367 * ratio + 0.0006 * ratio^2, else 0.693 - 0.0108 * H4
    var effectiveSolarVolume: Double? // Volume in liters of user defined tank size * 0.3
    var dailyHotH20: Double? // Volume in liters of user defined hot water demand
    var solarStorageVolFactor: Double? // 1 + 0.2 x ln(effectiveSolarVolume/dailyHotH20) (not to exceed 1.0)
    
    // MARK: - Methods

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
    
    func setCollectorApertureArea() {
        if let collectorHeight, let collectorWidth, let collectorAreaRatio {
            collectorApertureArea = collectorHeight * collectorWidth * collectorAreaRatio
        }
        // needs ratio from type to work
        // convert SF to m^2
    }
    
    func setSolarStorageVolFactor() {
        if let effectiveSolarVolume, let dailyHotH20 {
            solarStorageVolFactor = 1 + 0.2 * log(effectiveSolarVolume/dailyHotH20)
        } else {
            print("Missing Tank or Daily Hot H20 Volume Fields")
        }
    }
    
    // MARK: - Solar Contribution Formula
    // solarInput = collectorRadiation * overshadingFactor * collectorApertureArea * collectorEfficiency * utilizationFactor * collectorPerformanceFactor * solarStorageVolFactor
    
} // End of Class

// Notes to pick up tomorrow: Do you want to have user able to select specific month, gauge the output based on the available solar radiation that month based on selected collector tilt, and show an heat transfer results for that month? Or should we have user enter their location, find the kWh/m^2 and give the average from the year for a simulation length of a month duration? Keep it simple.
// Two dimensional arrays to represent the table data of collector factors
// Create whole simulation first with placeholder values and then replace with refined calculations

/*
 STC (standard test conditions):
 radiation = 1000 W/m^2
 cellTemp = 25 deg C
 windSpeed = 1m/s
 airMass = 1.5
 */
