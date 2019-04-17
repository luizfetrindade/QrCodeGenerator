//
//  Request.swift
//  nanoChallengApi
//
//  Created by Luiz Felipe Trindade on 16/04/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import Foundation
import UIKit

struct Request{
    func makeGetCall(data: String, size: String, completionHandler completion: @escaping (UIImage?) -> Void) {
        let str: String = "https://api.qrserver.com/v1/create-qr-code/?\(size)=\(size)&data=\(data)"
        if let url = URL(string: str) {
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            _ = session.dataTask(with: urlRequest) {
                (data, response, error) in
                guard error == nil else {
                    completion(nil)
                    print(error!)
                    return
                }
                if let responseData = data {
                    completion(UIImage(data: responseData))
                    return
                }
                }.resume()
        } else{ completion(nil) }
    }
}
