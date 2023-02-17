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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
