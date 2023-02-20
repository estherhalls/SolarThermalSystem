//
//  ResourcesTableViewController.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/19/23.
//

import UIKit

class ResourcesTableViewController: UITableViewController {
    
    // MARK: - Properties
    let dataSource = ResourcesModelController.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create Gradient Background Layer
        let gradientLayer = CAGradientLayer()
        /// Set the size of the layer to be equal to the size of the display
        gradientLayer.frame = view.bounds
        /// Set an array of core graphics colors (.cgColor) to create the gradient
        gradientLayer.colors = [UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.0).cgColor, UIColor(red: 0.80, green: 0.16, blue: 0.05, alpha: 0.25).cgColor]
        /// Rasterize this static layer to improve performance
        gradientLayer.shouldRasterize = true
        /// Apply the gradient to the backgroundGradient UIView
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.resourceData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell", for: indexPath)
        let data = dataSource.resourceData
        let resource = data[indexPath.row]
        cell.textLabel?.text = resource.title
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource.resourceData
        let resource = data[indexPath.row]
        let image = resource.image
        
        if let image {
            // Create a full-screen image view and display the image
            let newImageView = UIImageView(image: image)
            newImageView.frame = UIScreen.main.bounds
            newImageView.backgroundColor = .white
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        // Tap out of image to return to table view
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        
        sender.view?.removeFromSuperview()
    }
    
}
