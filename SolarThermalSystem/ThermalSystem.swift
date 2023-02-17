//
//  ThermalSystem.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/16/23.
//

import Foundation
struct ThermalSystem {
    // each of these is going to be defined by another function, but these are the elements that create the final solar contribution formula
    // solarInput = collectorRadiation * overshadingFactor * collectorApertureArea * collectorEfficiency * utilizationFactor * collectorPerformanceFactor * solarStorageVolFactor
    var solarInput: Double
    var collectorRadiation: Double
    var overshadingFactor: Double
    var collectorApertureArea: Double
    var collectorEfficiency: Double
    var utilizationFactor: Double
    var collectorHeatLossCoefficient: Double
    var collectorPerformanceFactor: Double
    var effectiveSolarVolume: Double
    var dailyHotH20: Double
    var solarStorageVolFactor: Double
    
    // Notes to pick up tomorrow: Do you want to have user able to select specific month, gauge the output based on the available solar radiation that month based on selected collector tilt, and show an heat transfer results for that month? Or should we have user enter their location, find the kWh/m^2 and give the average from the year for a simulation length of a month duration? Keep it simple.
    // Two dimensional arrays to represent the table data of collector factors
    // Create whole simulation first with placeholder values and then replace with refined calculations
    
}

/// STC (standard test conditions):
/// radiation = 1000 W/m^2
/// cellTemp = 25 deg C
/// windSpeed = 1m/s
/// airMass = 1.5
