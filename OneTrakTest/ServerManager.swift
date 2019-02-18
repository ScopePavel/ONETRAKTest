//
//  ServerManager.swift
//  OneTrakTest
//
//  Created by Pavel Scope on 05/02/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class ServerManager: NSObject {
    
    
    typealias GetModelClosure = (_ model: [Steps], _ error: Error?) -> Void
  
    
    static let shared = ServerManager()
    private override init() {}
    
 
    
    func getSteps(completion: @escaping GetModelClosure) {
        let urlString = "https://intern-f6251.firebaseio.com/intern/metric.json"
        let url = URL(string: urlString)!
        
        let dataTask = URLSession.shared.dataTask(with: url ) { (data, response, error) in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
                else {
                    return
            }
            do {
                let steps =  try  JSONDecoder().decode([Steps].self, from: data)
                completion (steps,error)
            } catch {
                print("some error")
            }
        }
        dataTask.resume()
    }

}
