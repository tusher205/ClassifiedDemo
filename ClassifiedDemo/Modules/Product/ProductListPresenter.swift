//
//  ProductListPresenter.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

@objc
protocol ProductPresenter {
    func loadViewData() -> Void
    func getclassifiedProductsCount() -> Int
    func getClassifiedItem(at index: Int) -> ClassifiedProduct?
    func sortClassifiedList(by property: ClassifiedListSegmentIndex)
    
    func onFetchThumbnail(name: String, completion: @escaping ImageClosure)
    func onFetchImage(name: String, completion: @escaping ImageClosure)
}

@objcMembers
class ProductListPresenter: NSObject {
    
    // MARK: Properties
    weak var view: ProductView?
    var router: ProductRouter
    
    typealias UseCase = (
        fetchItems: (_ completion: @escaping ClassifiedClosure) -> Void,
    fetchThumbnail: (_ name: String, _ completion: @escaping ImageClosure) -> Void,
        fetchImage: (_ name: String, _ completion: @escaping ImageClosure) -> Void
    )
    
    var interactors: UseCase?
    
    var classifiedProducts: [ClassifiedProduct]?
    
    init(view: ProductView,
         router: ProductRouter,
         useCase: ProductListPresenter.UseCase) {
        
        self.view = view
        self.router = router
        self.interactors = useCase
    }
}

extension ProductListPresenter: ProductPresenter {
    
    func loadViewData() {
//        if self.classifiedProducts?.count ?? 0 == 0 {
//            self.classifiedProducts = DummyResults.getDummyResults()
//            self.updateView(for: .featchItems)
//            return
//        }
//
        if self.classifiedProducts?.count ?? 0 > 0 {
            // Items already featched
            self.updateView(for: .featchItems)
        } else {
            self.fetchItems()
        }
    }
    
    func getclassifiedProductsCount() -> Int {
        return self.classifiedProducts?.count ?? 0
    }
    
    func getClassifiedItem(at index: Int) -> ClassifiedProduct? {
        if index >= getclassifiedProductsCount() {
            print("Invalid index")
            return nil
        }
        
        return self.classifiedProducts?[index]
    }
    
    func sortClassifiedList(by property: ClassifiedListSegmentIndex) {
        // Sort list by name, price in ascending order
        switch property {
        case .Name:
            self.classifiedProducts = classifiedProducts?.sorted(by: { $0.name?.lowercased() ?? "" < $1.name?.lowercased() ?? "" } )
            
        case .Price:
            self.classifiedProducts = classifiedProducts?.sorted(by: {
                let price1 = self.getPriceFromString($0.price ?? "")
                let price2 = self.getPriceFromString($1.price ?? "")
                
                if price1 < price2 {
                    return true
                }
                
                return false
            })
        }
    }
    
    func onFetchThumbnail(name: String, completion: @escaping ImageClosure) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactors?.fetchThumbnail(name) { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func onFetchImage(name: String, completion: @escaping ImageClosure) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactors?.fetchImage(name) { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    private func getPriceFromString(_ priceStr: String) -> Int {
        let priceSubString = priceStr.split(separator: " ")
        
        for price in priceSubString {
            if let p = Int(price) {
                return p
            }
        }
        
        return 0
    }
}

extension ProductListPresenter {
    func fetchItems() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactors?.fetchItems { (response) in
                if let results = response.results, results.count > 0 {
                    print("Received Classified Items: \(results.count)")
                    self?.classifiedProducts = results
                    self?.updateView(for: .featchItems)
                } else {
                    self?.updateView(for: .fetchError)
                }
            }
        }
    }
    
    func updateView(for state: ViewUpdateState) {
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .featchItems:
                self?.view?.showClassifiedItems()
                
            case .fetchImage, .fetchThumbnail:
                break
                
            case .fetchError:
                self?.view?.showError()
            }
        }
    }
    
}
