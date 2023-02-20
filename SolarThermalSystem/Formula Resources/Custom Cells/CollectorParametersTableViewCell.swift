//
//  CollectorParametersTableViewCell.swift
//  SolarThermalSystem
//
//  Created by Esther on 2/19/23.
//

import UIKit

class CollectorParametersTableViewCell: UITableViewCell {
    // MARK: - Outlets
    // MARK: - Properties
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    let thirdLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLabels() {
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(thirdLabel)

        // set up constraints for the labels
        let labelMargin: CGFloat = 16
        let labelSpacing: CGFloat = 8
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelMargin),
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelMargin),
            firstLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelMargin),
            
            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor, constant: labelSpacing),
            secondLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelMargin),
            secondLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelMargin),
            
            thirdLabel.leadingAnchor.constraint(equalTo: secondLabel.trailingAnchor, constant: labelSpacing),
            thirdLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelMargin),
            thirdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelMargin),
            thirdLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -labelMargin),
        ])
    }
}
