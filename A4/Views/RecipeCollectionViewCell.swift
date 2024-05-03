//
//  RecipeCollectionViewCell.swift
//  A4
//
//  Created by Jack Chen on 4/19/24.
//

import UIKit
import SDWebImage

class RecipeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties (Views)
    
    let recipeImage = UIImageView()
    
    let recipeName = UILabel()
    
    let rating = UILabel()
    
    let difficulty = UILabel()
    
    let bookmarked = UIImageView()
    
    
    // MARK: - Properties (data)
 
    static let reuse: String = "RecipeCollectionViewCellReuse"
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.a4.white
        layer.cornerRadius = 16
        clipsToBounds = true

        // MARK: - Call Functions

        setupRecipeImageView()
        setupRecipeNameLabel()
        setupRatingLabel()
        setupDifficultyLabel()
        setupBookmark()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        recipeImage.sd_setImage(with: URL(string: recipe.image_url ?? "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg"))
        recipeName.text = recipe.title
        rating.text = "\(recipe.rating ?? 2) •"
        difficulty.text = recipe.difficulty
        let bookmarkedArr = UserDefaults.standard.array(forKey: "bookmarked") as? [String] ?? []
        
        if bookmarkedArr.contains(recipe.title ?? ""){
            bookmarked.isHidden = false
        }else{
            bookmarked.isHidden = true
        }
    }
    
    // MARK: - Set Up Views
    private func setupRecipeImageView() {
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.layer.cornerRadius = 8
        recipeImage.clipsToBounds = true
        addSubview(recipeImage)
        
        // Setup constraints (assuming you are using Auto Layout)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeImage.heightAnchor.constraint(equalTo: recipeImage.widthAnchor) // Makes height equal to width for a 1:1 aspect ratio
        ])
    }
    
    private func setupRecipeNameLabel() {
        recipeName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        recipeName.numberOfLines = 2
        addSubview(recipeName)
        
        // Setup constraints
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeName.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 8),
            recipeName.leadingAnchor.constraint(equalTo: recipeImage.leadingAnchor, constant: 8),
            recipeName.trailingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: -20)
        ])
    }
    
    
    private func setupBookmark (){
        bookmarked.image = UIImage(systemName: "bookmark.fill")
        bookmarked.tintColor = UIColor.a4.yellowOrange
        bookmarked.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bookmarked)
        NSLayoutConstraint.activate([
            bookmarked.topAnchor.constraint(equalTo: recipeName.topAnchor),
            bookmarked.leadingAnchor.constraint(equalTo: recipeName.trailingAnchor),
            bookmarked.widthAnchor.constraint(equalToConstant: 20),
            bookmarked.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupRatingLabel() {
        rating.font = UIFont.systemFont(ofSize: 12)
        rating.textColor = UIColor.a4.silver
        addSubview(rating)
        
        // Setup constraints
        rating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rating.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 8),
            rating.leadingAnchor.constraint(equalTo: recipeName.leadingAnchor, constant: 8)
        ])
    }
  
    private func setupDifficultyLabel() {
        difficulty.font = UIFont.systemFont(ofSize: 12)
        difficulty.textColor = UIColor.a4.silver
        addSubview(difficulty)
        
        // Setup constraints
        difficulty.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            difficulty.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 8),
            difficulty.leadingAnchor.constraint(equalTo: rating.trailingAnchor, constant: 4)
        ])
    }
}
