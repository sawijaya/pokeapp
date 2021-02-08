//
//  PokemonViewController.swift
//  pokeapp
//
//  Created by Salim Wijaya on 05/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class PokemonViewController: UIViewController {
	var presenter: IPokemonModule!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var heightContent: NSLayoutConstraint!
    @IBOutlet weak var btnStats: UIButton!
    @IBOutlet weak var btnEvolutions: UIButton!
    @IBOutlet var btns: [UIButton]!
    var pokemonStatsView: PokemonStatsView?
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponent()
        
        self.setActiveButton(self.btnStats)
    }
    
    func setupComponent(){
        self.btnStats.layer.cornerRadius = 20
        self.btnStats.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
        
        self.btnEvolutions.layer.cornerRadius = 20
        self.btnEvolutions.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
    }
    
    func setActiveButton(_ button:UIButton) {
        self.btns.forEach { (btn) in
            btn.setTitleColor(UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1), for: UIControl.State.normal)
            btn.backgroundColor = UIColor.white
        }
        
        button.backgroundColor = UIColor(red: 77/255, green: 170/255, blue: 231/255, alpha: 1)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    func showStatsView(){
        
        if self.pokemonStatsView == nil {
            self.pokemonStatsView = PokemonStatsView.instantiate()
        }
        
        if let vw: PokemonStatsView = self.pokemonStatsView {
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
    
    func addEvolutionView(){
        
    }
    
    @IBAction func tapStatsView(_ sender: UIButton) {
        self.showStatsView()
        self.setActiveButton(sender)
    }
    
    @IBAction func tapEvolutionView(_ sender: UIButton) {
        self.hideStatsView()
        self.heightContent.constant = 100
        self.setActiveButton(sender)
    }
    
    deinit {
        print(#file, #function)
    }
}

extension PokemonViewController: IPokemonView {
}
