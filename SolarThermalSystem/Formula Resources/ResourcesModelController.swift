//
//  ResourcesModelController.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/19/23.
//

import UIKit

struct ResourcesModelController {
 
    static let shared = ResourcesModelController()
    
    var resourceData: [FormulaResource] = [
        FormulaResource(title: "Standard Assessment Procedure Heat Transfer Formula", image: UIImage(named: "SAPCalcFormula")),
        FormulaResource(title: "SAP Calculation Worksheet", image: UIImage(named: "SAPCalculationWorksheet")),
        FormulaResource(title: "SAP Collector Parameters", image: UIImage(named: "SAPCollectorParameters")),
        FormulaResource(title: "SAP Collector Position", image: UIImage(named: "SAPCollectorPosition")),
        FormulaResource(title: "SAP Volume Calculation", image: UIImage(named: "SAPVolumeCalc")),
        ]
    }
//        ["Standard Assessment Procedure Heat Transfer Formula" : UIImage(named: "SAPCalcFormula")],
//        ["SAP Calculation Worksheet" : UIImage(named: "SAPCalculationWorksheet")],
//        ["SAP Collector Parameters" : UIImage(named: "SAPCollectorParameters")],
//        ["SAP Collector Position" : UIImage(named: "SAPCollectorPosition")],
//        ["SAP Volume Calculation" : UIImage(named: "SAPVolumeCalc")]
//    ]

