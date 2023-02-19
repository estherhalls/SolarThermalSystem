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
    @IBOutlet weak var runSimulationButton: UIButton!
    @IBOutlet weak var systemImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    // MARK: - Properties
    let thermalSystem = ThermalSystem.shared
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
    }
    
    // MARK: - Methods
    /// Each method that deals with user input values needs to conclude by assigning that value to the model variables that will be accessed in the "run simulator" function
    func setupCollectorType(){
        /// Collector type assigned will also determine the collectorEfficiency, the linear heat loss coefficient (used in function that assigns collectorPerformanceFactor), and ratio of aperture area to gross area (which will be multiplied by the dimensions provided by the user)
        ///
        let optionClosure = { (action: UIAction) in
            print(action.title)
        }
        var optionsArray = [UIAction]()
        
        let typeData = dataSource.collectorParametersCalc.map { $0[0] }
        
        for type in typeData {
            /// Create action with type as title
            let action = UIAction(title: type as! String, state: .off, handler: optionClosure)
            
            /// Add new action to the options array
            optionsArray.append(action)
        }
        /// Set the first option state to on
        optionsArray[0].state = .on
        
        /// Create options menu
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        
        /// Add menu to button
        collectorTypePopupButton.menu = optionsMenu
        collectorTypePopupButton.showsMenuAsPrimaryAction = true
        collectorTypePopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func setupCollectorTilt(){
        /// Tilt and orientation are used together in an array to determine the annual solar radiation kWh/m2
        let optionClosure = { (action: UIAction) in
            print(action.title)
        }
        var optionsArray = [UIAction]()
        
        let tiltData = dataSource.annualRadiationCalc.map { $0[0] }
        
        for tilt in tiltData {
            /// Create action with type as title
            let action = UIAction(title: tilt as! String, state: .off, handler: optionClosure)
            
            /// Add new action to the options array
            optionsArray.append(action)
        }
        /// Set the first option state to on
        optionsArray[0].state = .on
        
        /// Create options menu
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        
        /// Add menu to button
        collectorTiltPopupButton.menu = optionsMenu
        collectorTiltPopupButton.showsMenuAsPrimaryAction = true
        collectorTiltPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func setupCollectorOrientation(){
        let optionClosure = { (action: UIAction) in
            print(action.title)}
        
        collectorOrientationPopupButton.menu = UIMenu(children : [
            UIAction(title: "option 1", state: .on, handler: optionClosure),
            UIAction(title: "option 2", handler: optionClosure),
            UIAction(title: "option 3", handler: optionClosure)
        ])
        collectorOrientationPopupButton.showsMenuAsPrimaryAction = true
        collectorOrientationPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func setupOvershading(){
        let optionClosure = { (action: UIAction) in
            print(action.title)}
        
        overshadingPopupButton.menu = UIMenu(children : [
            UIAction(title: "option 1", state: .on, handler: optionClosure),
            UIAction(title: "option 2", handler: optionClosure),
            UIAction(title: "option 3", handler: optionClosure)
        ])
        overshadingPopupButton.showsMenuAsPrimaryAction = true
        overshadingPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    func runSimulation() {
        
    }
    
} // End of Class
