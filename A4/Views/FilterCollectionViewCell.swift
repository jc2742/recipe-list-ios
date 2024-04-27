//
//  FilterCollectionViewCell.swift
//  A4
//
//  Created by Jack Chen on 4/20/24.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (Views)
    
    let difficultyLabel = UILabel()
    
    // MARK: - Properties (Data)
    static let reuse: String = "FilterCollectionViewCellReuse"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
                   
        layer.cornerRadius = 16
        clipsToBounds = true 

        // MARK: - Call Functions
        setupDifficultyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with difficulty: String) {
        let activeFilters = UserDefaults.standard.array(forKey: "activeFilters") as? [String] ?? []
        
        if activeFilters.contains(difficulty){
            backgroundColor = UIColor.a4.yellowOrange
            difficultyLabel.textColor = UIColor.a4.white
        }else{
            backgroundColor = UIColor.a4.offWhite
            difficultyLabel.textColor = UIColor.a4.black
        }
        difficultyLabel.text = difficulty
    }
    
    // MARK: - Set Up Views
    
    private func setupDifficultyLabel (){
        difficultyLabel.font = UIFont.systemFont(ofSize: 12)
        difficultyLabel.numberOfLines = 1
        
        addSubview(difficultyLabel)
        
        // Setup constraints
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            difficultyLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            difficultyLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
        
    }
}
