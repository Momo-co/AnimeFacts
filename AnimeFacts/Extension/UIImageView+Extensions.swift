//
//  UIImageView+Extensions.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from urlString: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
        guard let url = URL(string: urlString) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let _data = data, error == nil
                else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: _data)
                self.image = image
            }
            
        }
        
        dataTask.resume()
    }
}
