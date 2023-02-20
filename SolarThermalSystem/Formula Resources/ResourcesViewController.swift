//
//  ResourcesViewController.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/19/23.
//

import UIKit

class ResourcesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var resourcesTableView: UITableView!
    
    // MARK: - Properties
    let collectorParameters = SystemDataSource().collectorParametersCalc
    let annualRadiation = SystemDataSource().annualRadiationCalc
    let overshadingFactor = SystemDataSource().overshadingFactorCalc

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        resourcesTableView.dataSource = self
        resourcesTableView.delegate = self
        
        resourcesTableView.register(CollectorParametersTableViewCell.self, forCellReuseIdentifier: "collectorParametersCell")
//        view.addSubview(resourcesTableView)
    }
    
    
    
    // MARK: - Methods
 
    
    
}
// MARK: - Extensions
extension ResourcesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectorParameters.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "collectorParametersCell", for: indexPath) as! CollectorParametersTableViewCell
//               cell.firstLabel.text = "\(collectorParameters[indexPath.row][0])"
//               cell.secondLabel.text = "\(collectorParameters[indexPath.row][1])"
//               cell.thirdLabel.text = "\(collectorParameters[indexPath.row][2])"
////        let value = collectorParameters[indexPath.row][indexPath.section]
////        cell.textLabel?.text = "\(value)"
        return cell
    }
}

