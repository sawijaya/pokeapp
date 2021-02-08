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
    var offset: Int = 0
    var limit: Int = 20
    var isRequest: Bool = false
    var pokemons:[NSDictionary] = []
    
	override public func viewDidLoad() {
        super.viewDidLoad()
        
        let nib: UINib = UINib(nibName: "HomeViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: HomeViewCell.identifier)
        self.setUpNavigation()
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(viewWillRequest), userInfo: nil, repeats: false)
    }
    
    @objc func viewWillRequest(){
        self.request(true)
        
        self.requestType()
        self.requestAbility()
    }
    
    func requestType() {
        self.presenter.requestType()
    }
    
    func requestAbility() {
        self.presenter.requestAbility()
    }
    
    @objc func request(_ reload: Bool = true){
        if self.isRequest {
            return
        }
        
        if reload {
            self.isRequest = true
            self.pokemons = []
            self.offset = 0
            self.limit = 20
            self.presenter.fetchPokemon(self.limit, offset: self.offset)
        } else {
            self.isRequest = true
            print("offset \(self.offset)")
            self.offset += self.limit
            self.presenter.fetchPokemon(self.limit, offset: self.offset)
        }
        print(#function)
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
    public func loadPokemons(_ pokemons: [NSDictionary]) {
        self.isRequest = false
        self.pokemons.append(contentsOf: pokemons)
        self.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.identifier)!
        (cell as? HomeViewCell)?.pokemon = self.pokemons[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        let lastIndex: Int = self.pokemons.count - 1
        if index == lastIndex {
            print("request again")
            self.request(false)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon: NSDictionary = self.pokemons[indexPath.row]
        if let id: String = pokemon.value(forKey: "id") as? String,
           let idInt: Int = Int(id) {
            self.presenter.fetchPokemonById(idInt)
        }
//        self.presenter.presentPokemon(1)
    }
}
