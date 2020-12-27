//
//  ClassifiedService.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Alamofire

class ClassifiedService {
    private lazy var httpService = ClassifiedHttpService()
    private lazy var imageService = ImageHttpService() 
    static let shared : ClassifiedService = ClassifiedService()
}

extension ClassifiedService: ClassifiedAPI {
    func fetchClassifiedProducts(completion: @escaping ClassifiedClosure) {
        
        // Making http call to fetch classified items
        do {
            try ClassifiedHttpRouter
                .getClassifiedItems
                .request(usingHttpService: httpService)
                .responseJSON { (response) in
                    
                    let result = ClassifiedService.parseClassifedProduct(response)
                    completion(result)
            }
        } catch {
            print("Something went wrong while fetching classifed items \(error)")
        }
    }
}

extension ClassifiedService: ImagesAPI {
    func fetchThumbnail(name: String, completion: @escaping ImageClosure) {
        do {
            try ImageHttpRouter
                .downloadThumbnail(imageName: name)
                .download(using: imageService) { response in
                    guard let data = response.data, let image = UIImage(data: data) else { return }
                    completion(image)
                }
        } catch {
            print("Something went wrong while fetching thumbnail! = \(error)")
        }
    }
    
    func fetchImage(name: String, completion: @escaping ImageClosure) {
        do {
            try ImageHttpRouter
                .downloadImage(imageName: name)
                .download(using: imageService) { response in
                    guard let data = response.data, let image = UIImage(data: data) else { return }
                    completion(image)
                }
        } catch {
            print("Something went wrong while fetching image! = \(error)")
        }
    }
    
}

extension ClassifiedService {
    private static func parseClassifedProduct(_ result: DataResponse<Any>) -> ClassifiedResponse {
        
        guard [200, 201].contains(result.response?.statusCode), let data = result.data  else {
            return ClassifiedResponse()
        }
        
        do {
            return try JSONDecoder().decode(ClassifiedResponse.self, from: data)
        } catch {
            print("Error while parsing Classified Items response")
        }
        
        return ClassifiedResponse()
    }
}
