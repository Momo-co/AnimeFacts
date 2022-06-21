//
//  AnimeCoordinator.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import UIKit

protocol AnimeCoordinating {
    func start()
}

class AnimeCoordinator: AnimeCoordinating {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimeViewController")
        navigationController.viewControllers = [vc]
    }
}
