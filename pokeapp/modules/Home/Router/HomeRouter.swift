//
//  HomeRouter.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//  Copyright (c) 2021. All rights reserved.

import UIKit

public class HomeRouter: IHomeRouterIn {
	var interactor: IHomeInteractorIn?
	var presenter: IHomeModule?
	weak var view: IHomeView?
}
