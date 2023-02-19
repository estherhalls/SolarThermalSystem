//
//  UnitConversion.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/19/23.
//

import Foundation

extension Double {
    func convert(from originalUnit: UnitLength, to convertedUnit: UnitLength) -> Double {
        return Measurement(value: self, unit: originalUnit).converted(to: convertedUnit).value
    }
}
