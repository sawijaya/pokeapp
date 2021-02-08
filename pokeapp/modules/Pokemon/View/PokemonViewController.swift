//
//  PokemonViewController.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class PokemonViewController: UIViewController {
	var presenter: IPokemonModule!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var vwBackgroundColor: UIView!
    @IBOutlet weak var lblPokemonName: UILabel!
    @IBOutlet weak var imgvwPokemon: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var heightContent: NSLayoutConstraint!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwMenu: UIView!
    @IBOutlet weak var btnStats: UIButton!
    @IBOutlet weak var btnEvolutions: UIButton!
    @IBOutlet weak var imgvwType1: UIImageView!
    @IBOutlet weak var lblType1: UILabel!
    @IBOutlet weak var vwType1: UIView!
    
    @IBOutlet weak var lblType2: UILabel!
    @IBOutlet weak var imgvwType2: UIImageView!
    @IBOutlet weak var vwType2: UIView!
    @IBOutlet var lblTypes: [UILabel]!
    @IBOutlet var imgvwTypes: [UIImageView]!
    @IBOutlet var vwTypes: [UIView]!
    
    @IBOutlet var btns: [UIButton]!
    var pokemonStatsView: PokemonStatsView?
    var pokemonEvolutionView: PokemonEvolutionView?
    @IBOutlet weak var vwTab: UIView!
    @IBOutlet weak var btnTabStats: UIButton!
    @IBOutlet weak var btnTabEvolutions: UIButton!
    @IBOutlet var btnTabs: [UIButton]!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponent()
        self.setUpNavigation()
        
        self.tapStatsView(self.btnStats)
        
        self.loadData()
    }
    
    func loadData(){
        
        guard let pokemon:NSDictionary = self.presenter.pokemon else {
            return
        }
        print(pokemon)
        if let no: String = pokemon.value(forKey: "id") as? String, let url: URL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(no).png") {
            self.imgvwPokemon.kf.setImage(with: url)
        }
        
        let name: String = pokemon["name"] as? String ?? ""
        self.lblPokemonName.text = name.capitalizingFirstLetter()
        
        var _color:UIColor!
        if let color:String = pokemon["color"] as? String {
            _color = Pokemon.colors[color]
            self.vwBackgroundColor.backgroundColor = Pokemon.colors[color]
            let navigationBar: UINavigationBar = self.navigationController!.navigationBar
            navigationBar.barTintColor = Pokemon.colors[color]
        }
        
        if let types:[[String:Any]] = pokemon["types"] as? [[String:Any]] {
            var index:Int = 0
            for type in types {
                if index > self.vwTypes.count {
                    break;
                }
                let name:String = type["name"] as? String ?? ""
                self.vwTypes[index].isHidden = false
                self.vwTypes[index].backgroundColor = _color
                self.lblTypes[index].text = name.capitalizingFirstLetter()
                self.imgvwTypes[index].image = UIImage(named: name.capitalizingFirstLetter())
                
                index = index + 1
                
            }
            print(types)
        }
        
        self.lblDescription.text = pokemon["desc"] as? String ?? ""
        
        self.pokemonStatsView?.pokemon = self.presenter.pokemon
    }
    
    private func setUpNavigation() {
        let navigationBar: UINavigationBar = self.navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor(red: 97/255, green: 195/255, blue: 233/255, alpha: 1)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setupComponent(){
        self.btnStats.layer.cornerRadius = 20
        self.btnStats.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
        
        self.btnEvolutions.layer.cornerRadius = 20
        self.btnEvolutions.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
        
        self.btnTabStats.layer.cornerRadius = 20
        self.btnTabStats.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
        
        self.btnTabEvolutions.layer.cornerRadius = 20
        self.btnTabEvolutions.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
        
        self.vwContainer.layer.cornerRadius = 40
        
        self.vwTypes.sort { (vw1, vw2) -> Bool in
            return vw1.tag < vw2.tag
        }
        
        self.imgvwTypes.sort { (vw1, vw2) -> Bool in
            return vw1.tag < vw2.tag
        }
        
        self.lblTypes.sort { (vw1, vw2) -> Bool in
            return vw1.tag < vw2.tag
        }
        
        self.imgvwTypes.forEach { (imgvw) in
            imgvw.layer.cornerRadius = 11
        }
        
        self.vwTypes.forEach { (vw) in
            vw.layer.cornerRadius = 15
            vw.isHidden = true
        }
    }
    
    func setActiveButton(_ button:UIButton) {
        self.btns.forEach { (btn) in
            btn.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
            btn.backgroundColor = UIColor.white
        }
        
        self.btnTabs.forEach { (btn) in
            btn.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
            btn.backgroundColor = UIColor.white
        }
        
        if button == self.btnStats || button == self.btnTabStats {
            self.btnStats.backgroundColor = UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1)
            self.btnStats.setTitleColor(UIColor.white, for: UIControl.State.normal)
            
            self.btnTabStats.backgroundColor = UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1)
            self.btnTabStats.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else if button == self.btnEvolutions || button == self.btnTabEvolutions {
            self.btnEvolutions.backgroundColor = UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1)
            self.btnEvolutions.setTitleColor(UIColor.white, for: UIControl.State.normal)
            
            self.btnTabEvolutions.backgroundColor = UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1)
            self.btnTabEvolutions.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    func showStatsView(){
        
        if self.pokemonStatsView == nil {
            self.pokemonStatsView = PokemonStatsView.instantiate()
        }
        
        if let vw: PokemonStatsView = self.pokemonStatsView {
            self.pokemonStatsView?.backgroundColor = UIColor.clear
            self.heightContent.constant = vw.frame.height
            vw.translatesAutoresizingMaskIntoConstraints = false
            self.vwContent.addSubview(vw)
            vw.leadingAnchor.constraint(equalTo: self.vwContent.leadingAnchor).isActive = true
            vw.trailingAnchor.constraint(equalTo: self.vwContent.trailingAnchor).isActive = true
            vw.topAnchor.constraint(equalTo: self.vwContent.topAnchor).isActive = true
            vw.bottomAnchor.constraint(equalTo: self.vwContent.bottomAnchor).isActive = true
        }
    }
    
    func hideStatsView(){
        if let vw: PokemonStatsView = self.pokemonStatsView {
            vw.removeFromSuperview()
        }
    }
    
    func showEvolutionView(){
        if self.pokemonEvolutionView == nil {
            self.pokemonEvolutionView = PokemonEvolutionView.instantiate()
        }
        
        if let vw: PokemonEvolutionView = self.pokemonEvolutionView {
            self.pokemonEvolutionView?.backgroundColor = UIColor.clear
            self.heightContent.constant = vw.contentSize.height + 50
            vw.translatesAutoresizingMaskIntoConstraints = false
            self.vwContent.addSubview(vw)
            vw.leadingAnchor.constraint(equalTo: self.vwContent.leadingAnchor).isActive = true
            vw.trailingAnchor.constraint(equalTo: self.vwContent.trailingAnchor).isActive = true
            vw.topAnchor.constraint(equalTo: self.vwContent.topAnchor).isActive = true
            vw.bottomAnchor.constraint(equalTo: self.vwContent.bottomAnchor).isActive = true
        }
    }
    
    func hideEvolutionView(){
        if let vw: PokemonEvolutionView = self.pokemonEvolutionView {
            vw.removeFromSuperview()
        }
    }
    
    @IBAction func tapStatsView(_ sender: UIButton) {
        self.hideEvolutionView()
        self.showStatsView()
        self.setActiveButton(sender)
    }
    
    @IBAction func tapEvolutionView(_ sender: UIButton) {
        self.hideStatsView()
        self.showEvolutionView()
        self.setActiveButton(sender)
    }
    
    deinit {
        print(#file, #function)
    }
}

extension PokemonViewController: IPokemonView {
}

extension PokemonViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frameTilte: CGRect = self.lblPokemonName.convert(self.lblPokemonName.frame, to: self.view)
        let frameYTitle: CGFloat = frameTilte.origin.y
        let heightTitle: CGFloat = self.lblPokemonName.frame.height
        if frameYTitle < heightTitle {
            self.title = self.lblPokemonName.text
            self.lblPokemonName.isHidden = true
        } else {
            self.title = ""
            self.lblPokemonName.isHidden = false
        }
        
        let frameTab: CGRect = self.vwMenu.convert(self.vwTab.frame, to: self.view)
        if frameTab.origin.y < 0 {
            self.vwTab.isHidden = false
        } else {
            self.vwTab.isHidden = true
        }
        print("vwMenu \(self.vwMenu.convert(self.vwTab.frame, to: self.view))")
        print(scrollView.contentOffset.y)
    }
}
