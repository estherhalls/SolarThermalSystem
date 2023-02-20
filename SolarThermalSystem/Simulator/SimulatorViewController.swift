//
//  SimulatorViewController.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/17/23.
//

import UIKit

class SimulatorViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectorTypePopupButton: UIButton!
    @IBOutlet weak var collectorTiltPopupButton: UIButton!
    @IBOutlet weak var collectorOrientationPopupButton: UIButton!
    @IBOutlet weak var collectorWidthTextField: UITextField!
    @IBOutlet weak var collectorHeightTextField: UITextField!
    @IBOutlet weak var overshadingPopupButton: UIButton!
    @IBOutlet weak var tankVolumeTextField: UITextField!
    @IBOutlet weak var hotWaterDemandTextField: UITextField!
    @IBOutlet weak var systemImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var runSimulationButton: UIButton!
    @IBOutlet weak var dailyHeatTransferLabel: UILabel!
    @IBOutlet weak var solarInputLabel: UILabel!
    
    // MARK: - Properties
    // Initialize Model Properties
    var viewModel = SimulatorModelController.shared
    let dataSource = SystemDataSource()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Gradient Background Layer
        let gradientLayer = CAGradientLayer()
        /// Set the size of the layer to be equal to the size of the display
        gradientLayer.frame = view.bounds
        /// Set an array of core graphics colors (.cgColor) to create the gradient
        gradientLayer.colors = [UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor, UIColor(red: 0.80, green: 0.16, blue: 0.05, alpha: 1.00).cgColor]
        /// Rasterize this static layer to improve performance
        gradientLayer.shouldRasterize = true
        /// Apply the gradient to the backgroundGradient UIView
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Simulation Image
        let image = UIImage(named: "solarImage")
        DispatchQueue.main.async {
            self.systemImageView.image = image
        }
        // Initial Menus Setup
        setupCollectorType()
        setupCollectorTilt()
        setupCollectorOrientation()
        setupOvershading()
        
        // Result Labels Initial Values
        solarInputLabel.text = "-"
        dailyHeatTransferLabel.text = "-"
    }
    
    // MARK: - Methods
    /// Each method that deals with user input values needs to conclude by assigning that value to the model variables that will be accessed in the "run simulator" function
    
    func setupCollectorType() {
        /// Collector type assigned will also determine the collectorEfficiency, the linear heat loss coefficient (used in function that assigns collectorPerformanceFactor), and ratio of aperture area to gross area (which will be multiplied by the dimensions provided by the user)
        var optionsArray = [UIAction]()
        
        let typeData = dataSource.collectorParametersCalc.map { $0[0] }
        
        for (index, type) in typeData.enumerated() {
            // Create action with type as title
            let action = UIAction(title: "\(type)", state: .off) { (action: UIAction) in
                if let selectedIndex = optionsArray.firstIndex(of: action) {
                    // Find overshading factor in the 2D array that corresponds with the selected index, then assign the factor to model property for use in future functions
                    let efficiency = self.dataSource.collectorParametersCalc[selectedIndex][1]
                    let heatLoss = self.dataSource.collectorParametersCalc[selectedIndex][2]
                    let areaRatio = self.dataSource.collectorParametersCalc[selectedIndex][3]
                    self.viewModel.setCollectorType(with: action.title, efficiency: efficiency as! Double, heatLoss: heatLoss as! Int, areaRatio: areaRatio as! Double)
                }
            }
            // Add new action to the options array
            optionsArray.append(action)
        }
        // Set the first option state to on
        optionsArray[0].state = .on
        
        // Create options menu
        let optionsMenu = UIMenu(options: .displayInline, children: optionsArray)
        
        // Add menu to button
        collectorTypePopupButton.menu = optionsMenu
        collectorTypePopupButton.showsMenuAsPrimaryAction = true
        collectorTypePopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func setupCollectorTilt() {
        /// Tilt and orientation are used together in an array to determine the annual solar radiation kWh/m2
        var optionsArray = [UIAction]()
        
        let tiltData = dataSource.annualRadiationCalc.map { $0[0] }
        
        for (index, tilt) in tiltData.enumerated() {
            // Create action with type as title
            let action = UIAction(title: "\(tilt)", state: .off) { (action: UIAction) in
                if let selectedIndex = optionsArray.firstIndex(of: action) {
                    self.viewModel.setCollectorTilt(with: selectedIndex)
                    print("Collector Tilt: \(action.title)")
                }
            }
            // Add new action to the options array
            optionsArray.append(action)
        }
        // Set the first option state to on
        optionsArray[0].state = .on
        
        // Create options menu
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        
        // Add menu to button
        collectorTiltPopupButton.menu = optionsMenu
        collectorTiltPopupButton.showsMenuAsPrimaryAction = true
        collectorTiltPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func setupCollectorOrientation() {
        var optionsArray = [UIAction]()
        
        let orientationData = dataSource.annualRadiationCalc[0]

        /// Used array slicing syntax here to set range so that 2D array is set up in a way that can also be displayed on Resources tab
        let directionArray = orientationData[1..<orientationData.count]
        for (index, direction) in directionArray.enumerated() {
            // Create action with type as title
            let action = UIAction(title: "\(direction)", state: .off) { (action: UIAction) in
                if let selectedIndex = optionsArray.firstIndex(of: action) {
                    self.viewModel.setCollectorOrientation(with: selectedIndex)
                    print("Collector Orientation: \(action.title)")
                }
            }
            // Add new action to the options array
            optionsArray.append(action)
        }
        // Set the first option state to on
        optionsArray[0].state = .on
        
        // Create options menu
        let optionsMenu = UIMenu(options: .displayInline, children: optionsArray)
        
        // Add menu to button
        collectorOrientationPopupButton.menu = optionsMenu
        collectorOrientationPopupButton.showsMenuAsPrimaryAction = true
        collectorOrientationPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func setupOvershading() {
        var optionsArray = [UIAction]()
        
        let overshadingData = dataSource.overshadingFactorCalc.map { $0[0] }
        
        for (index, coverage) in overshadingData.enumerated() {
            // Create action with type as title
            let action = UIAction(title: "\(coverage)", state: .off) { (action: UIAction) in
                if let selectedIndex = optionsArray.firstIndex(of: action) {
                    // Find overshading factor in the 2D array that corresponds with the selected index, then assign the factor to model property for use in future functions
                    let overshadingFactor = self.dataSource.overshadingFactorCalc[selectedIndex][2]
                    self.viewModel.setOvershadingFactor(with: overshadingFactor as! Double)
                    print("Overshading: \(action.title)")
                }
            }
            // Add new action to the options array
            optionsArray.append(action)
        }
        // Set the first option state to on
        optionsArray[0].state = .on
        
        // Create options menu
        let optionsMenu = UIMenu(options: .displayInline, children: optionsArray)
        
        // Add menu to button
        overshadingPopupButton.menu = optionsMenu
        overshadingPopupButton.showsMenuAsPrimaryAction = true
        overshadingPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func setTextFields() {
        if let height = collectorHeightTextField.text, let value = Double(height) {
            let convertedValue = value.convert(from: .feet, to: .meters)
            viewModel.collectorHeight = convertedValue
            print(viewModel.collectorHeight!)
        } else {
            valueErrorAlert()
            print("Missing Height Text Field")
        }
        if let width = collectorWidthTextField.text, let value = Double(width) {
            let convertedValue = value.convert(from: .feet, to: .meters)
            viewModel.collectorWidth = convertedValue
            print(viewModel.collectorWidth!)
        } else {
            valueErrorAlert()
            print("Missing Width Text Field")
        }
        if let tank = tankVolumeTextField.text, let value = Double(tank) {
            let gallons = value
            let convertedValue = gallons * 3.78541 // Gallons to liters
            viewModel.tankVolume = convertedValue
            print(viewModel.tankVolume!)
        } else {
            valueErrorAlert()
            print("Missing Tank Volume Text Field")
        }
        if let h20Demand = hotWaterDemandTextField.text, let value = Double(h20Demand) {
            let gallons = value
            let convertedValue = gallons * 3.78541 // Gallons to liters
            viewModel.dailyHotH20 = convertedValue
            print(viewModel.dailyHotH20!)
        } else {
            valueErrorAlert()
            print("Missing H20 Demand Text Field")
        }
    }
    
    func valueErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "One or More Fields Has Invalid Input Value", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func runSimulationTapped(_ sender: Any) {
        // First assign text fields to global properties
        setTextFields()
        // final daily heat transfer and solar input formulas
        viewModel.prepareFinalFormulaTerms()
       
        let annualSolarContribution = viewModel.solarInputFormula(viewController: self) ?? 0
        let dailyHeatTransfer = Double(round(annualSolarContribution / 365))
        
        solarInputLabel.text = "\(annualSolarContribution)"
        print("Solar Contribution to Thermal System: \(annualSolarContribution)")
        
        dailyHeatTransferLabel.text = "\(dailyHeatTransfer)"
        print("Daily Heat Transfer: \(dailyHeatTransfer)")
    }
    
} // End of Class
