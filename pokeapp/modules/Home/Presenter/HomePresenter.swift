//
//  HomePresenter.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class HomePresenter: IHomeModule {
	
	var interactor: IHomeInteractorIn?
	var router: IHomeRouterIn?
	weak var view: IHomeView?
	public var parameters: [String: Any]?
	
	public init() {
	}
}

extension HomePresenter: IHomeInteractorOut {
	
}
