//
//  HomeViewController.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class HomeViewController: UIViewController {
	var presenter: IHomeModule!
    @IBOutlet weak var tableView: UITableView!
    
	override public func viewDidLoad() {
        super.viewDidLoad()
        
        let nib: UINib = UINib(nibName: "HomeViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: HomeViewCell.identifier)
        self.setUpNavigation()
    }
    
    private func setUpNavigation() {
        let navigationBar: UINavigationBar = self.navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let navController = navigationController!
        let image = UIImage(named: "pokemon-title.png") //Your logo url here
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }

    deinit {
        print(#file, #function)
    }
}

extension HomeViewController: IHomeView {
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.identifier)!
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
