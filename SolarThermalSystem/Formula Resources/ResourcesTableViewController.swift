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
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let image = dataSource[indexPath.row]["image"] as? UIImage
//
//          if let image = image {
//              // Create a full-screen image view and display the image
//              let newImageView = UIImageView(image: image)
//              newImageView.frame = UIScreen.main.bounds
//              newImageView.backgroundColor = .black
//              newImageView.contentMode = .scaleAspectFit
//              newImageView.isUserInteractionEnabled = true
//              let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
//              newImageView.addGestureRecognizer(tap)
//              self.view.addSubview(newImageView)
//              self.navigationController?.isNavigationBarHidden = true
//              self.tabBarController?.tabBar.isHidden = true
//          }
//    }
//
//    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
//        navigationController?.isNavigationBarHidden = false
//        tabBarController?.tabBar.isHidden = false
//
//        sender.view?.removeFromSuperview()
//    }

}
