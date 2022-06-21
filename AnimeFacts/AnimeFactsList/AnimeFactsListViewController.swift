//
//  AnimeFactsListViewController.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import UIKit
import Combine

class AnimeFactsListViewController: UIViewController {
    
    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var animeFactsTableView: UITableView!
    
    var viewModel: AnimeFactsViewModel?
    var cancellable:AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getAnimeFacts()
        title = viewModel?.rewriteAnimeNameTitle()
        cancellable = viewModel?.$animeFacts.sink(receiveValue: { animeFacts in
            self.animeImageView.downloaded(from: animeFacts.img)
            DispatchQueue.main.async {
                self.animeFactsTableView.reloadData()
            }
        })
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        animeImageView.addGestureRecognizer(tapGR)
        animeImageView.isUserInteractionEnabled = true
        animeFactsTableView.dataSource = self
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            viewModel?.openImageURL()
        }
    }
}

extension AnimeFactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.animeFacts.totalFacts ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = animeFactsTableView.dequeueReusableCell(withIdentifier: "animeFactsTableViewCell") as? AnimeFactsTableViewCell else {
            return UITableViewCell()
        }
        if let currentCellFact = viewModel?.getAnimeFact(index: indexPath.row) {
            cell.setUpFactDescription(fact: currentCellFact)
        }
        
        return cell
    }
}
