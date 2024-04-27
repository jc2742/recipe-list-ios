//
//  UIViewController.swift
//  A4
//
//  Created by Jack Chen on 4/19/24.
//

import UIKit
import SDWebImage

protocol RecipeViewControllerDelegate: AnyObject {
    func recipeDidUpdateBookmark()
}

class RecipeVC: UIViewController {
    // MARK: - Properties (Views)
    let recipeImageView = UIImageView()
    let recipeNameLabel = UILabel()
    let recipeDescriptionLabel = UILabel()
    let bookmark = UIBarButtonItem()
    let backButton = UIBarButtonItem()
    
    // MARK: - Properties (Data)
    var recipe: Recipe?
    weak var delegate: RecipeViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupRecipeImageView()
        setupRecipeNameLabel()
        setupRecipeDescriptionLabel()
        setupBookmarkButton()
        setupBackButton()
        
        configureViewsWithRecipe()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func bookmarkRecipe(){
        var bookmarked = UserDefaults.standard.array(forKey: "bookmarked") as? [String] ?? []
        let item = recipeNameLabel.text ?? ""
        if ( item != "" && bookmarked.contains(item)){
            bookmarked.removeAll { recipe in
                recipe == item                         }
        } else {
            bookmarked.append(item)
        }
        
        UserDefaults.standard.setValue(bookmarked, forKey: "bookmarked")
        updateBookmark(recipe: item)
        delegate?.recipeDidUpdateBookmark()
    }
    
    private func updateBookmark (recipe:String){
        let bookmarked = UserDefaults.standard.array(forKey: "bookmarked") as? [String] ?? []
        
        if bookmarked.contains(recipe){
            self.bookmark.image = UIImage(systemName: "bookmark.fill")
        }else{
            self.bookmark.image = UIImage(systemName: "bookmark")
        }
    }
        
    // MARK: - Setup Views
    private func setupBackButton(){
        backButton.image = UIImage(systemName: "arrow.left")
        backButton.target = self
        backButton.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupRecipeImageView() {
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 8
        recipeImageView.clipsToBounds = true
        view.addSubview(recipeImageView)
        
        // Setup constraints
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            recipeImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 320),
            recipeImageView.widthAnchor.constraint(equalToConstant: 320)
        ])
    }

    private func setupRecipeNameLabel() {
        recipeNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        recipeNameLabel.numberOfLines = 1
        recipeNameLabel.textAlignment = .left
        view.addSubview(recipeNameLabel)
        
        // Setup constraints
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 24),
            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            recipeNameLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor)
        ])
    }

    private func setupRecipeDescriptionLabel() {
        recipeDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        recipeDescriptionLabel.numberOfLines = 0
        recipeDescriptionLabel.textAlignment = .left
        recipeDescriptionLabel.textColor = UIColor.a4.silver
        view.addSubview(recipeDescriptionLabel)
        
        // Setup constraints
        recipeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeDescriptionLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 24),
            recipeDescriptionLabel.leadingAnchor.constraint(equalTo: recipeNameLabel.leadingAnchor ),
            recipeDescriptionLabel.trailingAnchor.constraint(equalTo: recipeNameLabel.trailingAnchor),
            recipeDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16) // Ensure it does not extend beyond the safe area
        ])
    }
    
    private func setupBookmarkButton() {
        bookmark.image = UIImage(systemName: "bookmark")
        bookmark.tintColor = UIColor.a4.black
        bookmark.target = self
        bookmark.action =  #selector(bookmarkRecipe)
        navigationItem.rightBarButtonItem = bookmark
    }

    // MARK: - Configure
    private func configureViewsWithRecipe() {
        guard let recipe = recipe else { return }
        recipeImageView.sd_setImage(with: URL(string: recipe.image_url))
        recipeNameLabel.text = recipe.name
        recipeDescriptionLabel.text = recipe.description
        updateBookmark(recipe: recipe.name)
    }
}
