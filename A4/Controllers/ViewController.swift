//
//  ViewController.swift
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties (view)
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    private var filterCollectionView: UICollectionView!

    
    // MARK: - Properties (data)
    
    let filters = ["All", "Beginner", "Intermediate","Advanced"]
    
    private var recipes: [Recipe] = [
        
    ]
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        title = "Chef OS"
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32, weight: .bold)]
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupFilterViews ()
        setupCollectionViews ()
        fetchRecipes()
    }
    
    func getFilteredRecipes () -> [Recipe]{
        let activeFilters = UserDefaults.standard.array(forKey: "activeFilters") as? [String] ?? []
        
        let filteredRecipes = recipes.filter { recipe in
            return (activeFilters.contains(recipe.difficulty) || activeFilters.contains("All") || activeFilters.count == 0)
        }
        return filteredRecipes
    }
    
    @objc private func fetchRecipes() {
        NetworkManager.shared.fetchRecipes { [weak self] recipes in
            guard let self = self else { return }
            self.recipes = recipes
            print(recipes)
            
            // Perform UI update on main queue
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    
    // MARK: - Set Up Views
    private func setupFilterViews (){
        let padding: CGFloat = 24
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)

       filterCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40), collectionViewLayout: layout)
        filterCollectionView.showsHorizontalScrollIndicator = false
        
       filterCollectionView.alwaysBounceHorizontal = true
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuse)

       filterCollectionView.delegate = self
       filterCollectionView.dataSource = self

       view.addSubview(filterCollectionView)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
    private func setupCollectionViews (){
        let padding: CGFloat = 24
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width - 2 * padding, height: 120)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.a4.white
        collectionView.alwaysBounceVertical = true
    
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuse)
        

        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
        
        refreshControl.addTarget(self, action: #selector(fetchRecipes), for: .valueChanged)

        collectionView.refreshControl = refreshControl

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

        ])
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.collectionView){
            let recipe = getFilteredRecipes()[indexPath.row]
            let detailVC = RecipeVC()
            detailVC.recipe = recipe
            detailVC.delegate = self
            navigationController?.pushViewController(detailVC, animated: true)
        }else{
            let difficulty = filters[indexPath.row]
            var activeFilters = UserDefaults.standard.array(forKey: "activeFilters") as? [String] ?? []
            
            if activeFilters.contains(difficulty) {
                activeFilters.removeAll { filter in
                    filter == difficulty                         }
            } else {
                activeFilters.append(difficulty)
            }
            
            UserDefaults.standard.setValue(activeFilters, forKey: "activeFilters")
            collectionView.reloadData()
            self.collectionView.reloadData()
        }
    }
    func testing (){
        self.collectionView.reloadData()
    }
    
}


extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == filterCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuse, for: indexPath) as! FilterCollectionViewCell
            let difficulty = filters[indexPath.row]
            cell.configure(with: difficulty)
            return cell
            
        }else if(collectionView == self.collectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuse, for: indexPath) as! RecipeCollectionViewCell
            let recipe:Recipe = getFilteredRecipes()[indexPath.row]
            cell.configure(with: recipe)
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuse, for: indexPath) as! RecipeCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == filterCollectionView) {
            return filters.count
        }else{
            return getFilteredRecipes().count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: Return the number of sections in this table view

        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if (collectionView == filterCollectionView) {
            return UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        }else{
            return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
    }


}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (collectionView == filterCollectionView) {
            let labelWidth = filters[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]).width + 80
            return CGSize(width: labelWidth, height: 30)
        }else{
            let padding: CGFloat = 16
            let availableWidth = collectionView.bounds.width - (padding * 3)
            let widthPerItem = floor(availableWidth / 2)
            return CGSize(width: widthPerItem, height: 216)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16 // Space between rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16 // Space between items within the same row
    }
}

extension ViewController: RecipeViewControllerDelegate {
    func recipeDidUpdateBookmark() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
