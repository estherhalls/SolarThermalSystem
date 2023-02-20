//
//  SimulatorModelController.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/18/23.
//

import UIKit
class SimulatorModelController {
    
    // MARK: - Singleton
    static let shared = SimulatorModelController()
    
    // MARK: - Properties
    let dataSource = SystemDataSource()
    
    // User established and associated values
    var collectorType: String?
    var collectorEfficiency: Double?
    var collectorHeatLossCoefficient: Int?
    var collectorTiltIndex: Int?
    var collectorOrientationIndex: Int?
    var collectorWidth: Double?
    var collectorHeight: Double?
    var collectorAreaRatio: Double?
    var annualRadiation: Int?
    var solarInput: Double? // result of solar contribution formula
    var overshadingFactor: Double? // Factor associated with user assigned shading quantity
    var tankVolume: Double?
    var dailyHotH20: Double? // Volume in liters of user defined hot water demand
    
    // Computed Properties that will be used as terms for expressions in solar contribution and heat transfer formulas
    var collectorApertureArea: Double? // collectorHeight * collectorWidth * ratio
    var collectorPerformanceFactor: Double? // heat loss coefficient/collector efficiency determined by collector type (ratio)-> if ratio < 20 = 0.97 - 0.0367 * ratio + 0.0006 * ratio^2, else 0.693 - 0.0108 * H4
    var solarStorageVolFactor: Double? // 1 + 0.2 x ln(effectiveSolarVolume/dailyHotH20) (not to exceed 1.0)
    
    // MARK: - Methods
    func setCollectorType(with name: String, efficiency: Double, heatLoss: Int, areaRatio: Double) {
        collectorType = name
        collectorEfficiency = efficiency
        collectorHeatLossCoefficient = heatLoss
        collectorAreaRatio = areaRatio
        print("Collector Type: \(collectorType!), Zero-Loss Collector Efficiency: \(collectorEfficiency!), Linear Heat Loss Coefficient: \(collectorHeatLossCoefficient!), Ratio of Aperture to Gross Area: \(collectorAreaRatio!)")
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
        let heatLoss = Double(collectorHeatLossCoefficient)
        let performanceRatio = heatLoss / collectorEfficiency
        if performanceRatio < 20.0 {
            collectorPerformanceFactor = 0.97 - 0.0367 * performanceRatio + 0.0006 * pow(performanceRatio, 2)
        } else {
            collectorPerformanceFactor = 0.693 - 0.0108 * performanceRatio
        }
    }
    
    func prepareFinalFormulaTerms() {
        setAnnualRadiation()
        setCollectorApertureArea()
        setSolarStorageVolFactor()
        setCollectorPerformanceFactor()
    }
    
    // MARK: - Solar Contribution Formula
    func solarInputFormula(viewController: UIViewController) -> Double? {
        // Solar Input Formula:  solarInput = collectorRadiation * overshadingFactor * collectorApertureArea * collectorEfficiency * utilizationFactor * collectorPerformanceFactor * solarStorageVolFactor
        
        guard let annualRadiation, let overshadingFactor, let collectorApertureArea, let collectorPerformanceFactor, let solarStorageVolFactor else {
            let alertController = UIAlertController(title: "Error", message: "Please Check That All Fields are Complete", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true, completion: nil)
            return nil
        }
        // Perform calculation
        let adjustedRadiation = Double(annualRadiation)
        
        let result = adjustedRadiation * overshadingFactor * collectorApertureArea * collectorPerformanceFactor * solarStorageVolFactor
        
        // Ensure result is a valid number
        if result.isNaN || result.isInfinite {
            let alertController = UIAlertController(title: "Error", message: "One or More Fields Has Invalid Input Value", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true, completion: nil)
            return nil
        }
        return Double(round(result))
    }
    
} // End of Class
