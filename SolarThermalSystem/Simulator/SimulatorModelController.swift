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
    let dataSource = SystemDataSource()
    
    // User established and associated values
    var collectorType: String?
    var collectorEfficiency: Double?
    var collectorHeatLossCoefficient: Double?
    var collectorTiltIndex: Int?
    var collectorOrientationIndex: Int?
    var collectorWidth: Double?
    var collectorHeight: Double?
    var collectorAreaRatio: Double?
    var annualRadiation: Int?
    var solarInput: Int? // result of solar contribution formula
    var overshadingFactor: Double? // Factor associated with user assigned shading quantity
    var tankVolume: Double?
    var dailyHotH20: Double? // Volume in liters of user defined hot water demand
    
    // Computed Properties that will be used as terms for expressions in solar contribution and heat transfer formulas
    var collectorApertureArea: Double? // collectorHeight * collectorWidth * ratio
    var collectorPerformanceFactor: Double? // heat loss coefficient/collector efficiency determined by collector type (ratio)-> if ratio < 20 = 0.97 - 0.0367 * ratio + 0.0006 * ratio^2, else 0.693 - 0.0108 * H4
    var solarStorageVolFactor: Double? // 1 + 0.2 x ln(effectiveSolarVolume/dailyHotH20) (not to exceed 1.0)
    
    // MARK: - Methods
    
    func setCollectorType(with name: String, efficiency: Double, heatLoss: Double, areaRatio: Double) {
        collectorType = name
        collectorEfficiency = efficiency
        collectorHeatLossCoefficient = heatLoss
        collectorAreaRatio = areaRatio
        print("Collector Type: \(collectorType!), Zero-Loss Collector Efficiency: \(collectorEfficiency!), Linear Heat Loss Coefficient: \(collectorHeatLossCoefficient!), Ratio of Aperture to Gross Area: \(collectorAreaRatio!)")
        setCollectorPerformanceFactor()
    }
    
    func setCollectorTilt(with index: Int) {
        collectorTiltIndex = index
        print(collectorTiltIndex!)
    }
    
    func setCollectorOrientation(with index: Int) {
        collectorOrientationIndex = index + 1
        print(collectorOrientationIndex!)
    }
    
    func setOvershadingFactor(with factor: Double) {
        overshadingFactor = factor
        print(overshadingFactor!)
    }
    
    func setAnnualRadiation() {
        guard let collectorTiltIndex, let collectorOrientationIndex else { return }
        annualRadiation = (dataSource.annualRadiationCalc[collectorTiltIndex][collectorOrientationIndex] as! Int)
    }
    
    func setCollectorApertureArea() {
        if let collectorHeight, let collectorWidth, let collectorAreaRatio {
            collectorApertureArea = collectorHeight * collectorWidth * collectorAreaRatio
        }
    }
    
    func setSolarStorageVolFactor() {
        if let tankVolume, let dailyHotH20 {
            let effectiveSolarVolume = tankVolume * 0.3
            solarStorageVolFactor = 1 + 0.2 * log(effectiveSolarVolume/dailyHotH20)
        } else {
            print("Missing Tank or Daily Hot H20 Volume Fields")
        }
    }
    
    func setCollectorPerformanceFactor() {
        // heat loss coefficient/collector efficiency determined by collector type (ratio)-> if ratio < 20 = 0.97 - 0.0367 * ratio + 0.0006 * ratio^2, else 0.693 - 0.0108 * H4
        guard let collectorHeatLossCoefficient, let collectorEfficiency else { return }
        let performanceRatio = collectorHeatLossCoefficient / collectorEfficiency
        if performanceRatio < 20.0 {
            collectorPerformanceFactor = 0.97 - 0.0367 * performanceRatio + 0.0006 * performanceRatio^2
        } else {
            collectorPerformanceFactor = 0.693 - 0.0108 * performanceRatio
        }
    }
    
    func prepareFinalFormulaTerms() {
        setAnnualRadiation()
        setCollectorApertureArea()
        setSolarStorageVolFactor()
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
