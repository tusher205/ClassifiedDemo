//
//  ClassifiedAPI.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

typealias ClassifiedClosure = (ClassifiedResponse) -> (Void)

protocol ClassifiedAPI {
    func fetchClassifiedProducts(completion: @escaping ClassifiedClosure) -> (Void)
}
