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
    @IBOutlet weak var systemImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
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
        
        let image = UIImage(named: "solarImage")
        DispatchQueue.main.async {
            self.systemImageView.image = image
        }
        // Initial Menus Setup
        setupCollectorType()
    }
    
    // MARK: - Methods
    func setupCollectorType(){
        let optionClosure = { (action: UIAction) in
            print(action.title)}
        
        collectorTypePopupButton.menu = UIMenu(children : [
            UIAction(title: "option 1", state: .on, handler: optionClosure),
            UIAction(title: "option 2", handler: optionClosure),
            UIAction(title: "option 3", handler: optionClosure)
        ])
        collectorTypePopupButton.showsMenuAsPrimaryAction = true
        collectorTypePopupButton.changesSelectionAsPrimaryAction = true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
