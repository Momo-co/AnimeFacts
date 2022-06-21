//
//  AnimeFactsCoordinator.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import UIKit
import SafariServices

protocol AnimeFactsCoordinating {
    func open(imageURLString: String)
}

class AnimeFactsCoordinator: AnimeFactsCoordinating {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func open(imageURLString: String) {
        guard let url = URL(string: imageURLString) else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        navigationController.present(safariViewController, animated: true, completion: nil)
    }
}
