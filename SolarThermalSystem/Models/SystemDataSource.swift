//
//  SystemDataSource.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/18/23.
//

import Foundation

struct SystemDataSource {
    // Collector Parameters: Type, Efficiency, Linear Heat Loss Coefficient, Ratio of Aperture Area to Gross Area
    let collectorParametersCalc = [
        ["Collector Type", "Zero-loss Collector Efficiency", "Linear Heat Loss Coefficient", "Ratio of Aperture Area to Gross Area"],
        ["Flat Plate, Glazed", 0.75, 6, 0.90],
        ["Evacuated Tube", 0.6, 3, 0.72],
        ["Flat Plate, Unglazed", 0.9, 20, 1.0]
    ]
    
    // Annual Solar Radiation, kWh/m^2, based on collector tilt and orientation
    let annualRadiationCalc = [
        ["Tilt", "Orientation", "South", "SE/SW", "E/W", "NE/NW", "North"],
        ["Horizontal", "", 961, 961, 961, 961, 961],
        ["30°", "", 1073, 1027, 913, 785, 730],
        ["45°", "", 1054, 997, 854, 686, 640],
        ["60°", "", 989, 927, 776, 597, 500],
        ["Vertical", "", 746, 705, 582, 440, 371]
    ]
    
    // Overshading Factor
    let overshadingFactorCalc = [
        ["Overshading", "% of Sky Blocked by Obstacles", "Overshading Factor"],
        ["Heavy", "> 80%", 0.5],
        ["Significant", "60 - 80%", 0.65],
        ["Modest", "20 - 60%", 0.8],
        ["None or Very Little", "< 20%", 1.0]
    ]
}
