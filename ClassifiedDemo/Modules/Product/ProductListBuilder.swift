//
//  ProductListBuilder.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

class ProductListBuilder {
    
    static func build() -> UIViewController {
        let view = ProductListViewController()
        let classifiedInteractor = ProductListInteractor(service: ClassifiedService.shared)
        let imageInteractor = ImageInteractor(service: ClassifiedService.shared)
        let router = ProductListRouter(view: view)
        let presenter = ProductListPresenter(view: view,
                                                router: router,
                                                useCase: (
                                                    fetchItems: classifiedInteractor.fetchClassifiedItems,
                                                    fetchThumbnail: imageInteractor.fetchThumbnail,
                                                    fetchImage: imageInteractor.fetchImage
        ))
        
        view.presenter = presenter
        
        return view
    }
}
