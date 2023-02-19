//
//  SimulatorModelController.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/18/23.
//

import Foundation
struct SimulatorModelController {
    // set up generic computed functions that will need to take in assigned variables and return the value that is accessed for the final heat transfer and solar input formulas. These will be called in view controller "run simulator" action
    /// Terms for expressions in solar contribution and heat transfer formulas
    var solarInput: Int?
    var collectorRadiation: Double?
    var overshadingFactor: Double? // Factor associated with user assigned shading quantity
    var collectorApertureArea: Double? // collectorHeight * collectorWidth * ratio
    var collectorEfficiency: Double? // associated with user assigned collector type
//    var utilizationFactor: Double? // this is 0. we can remove
    var collectorHeatLossCoefficient: Int? // associated with user assigned collector type
    var collectorPerformanceFactor: Double? // heat loss coefficient/collector efficiency determined by collector type (ratio)-> if ratio < 20 = 0.97 - 0.0367 * ratio + 0.0006 * ratio^2, elsee 0.693 - 0.0108 * H4
    var effectiveSolarVolume: Double? // Volume in liters of user defined tank size * 0.3
    var dailyHotH20: Double? // Volume in liters of user defined hot water demand
    var solarStorageVolFactor: Double? // 1 + 0.2 x ln(effectiveSolarVolume/dailyHotH20) (not to exceed 1.0)
    
    // MARK: - Solar Contribution Formula
    // solarInput = collectorRadiation * overshadingFactor * collectorApertureArea * collectorEfficiency * utilizationFactor * collectorPerformanceFactor * solarStorageVolFactor

}
