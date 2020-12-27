//
//  ProductListRouter.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

protocol ProductRouter {
    
}

class ProductListRouter {
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }
}

extension ProductListRouter: ProductRouter {
    
}
