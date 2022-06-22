//
//  ViewController.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 20/06/2022.
//

import UIKit
import Combine

class AnimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let animeViewModel = AnimeViewModel(animeService: AnimeService())
    
    weak var coordinator: AnimeCoordinating?
    var cancellable:AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Anime"
        animeViewModel.getAnimes()
        cancellable = animeViewModel.$animes.sink(receiveValue: { animes in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancellable?.cancel()
    }
}

extension AnimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeViewModel.animes.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = Identifier.animeTableViewCell.rawValue
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AnimeTableViewCell else {
            return UITableViewCell()
        }
        let animeCellList = animeViewModel.getAnimeList()
        let currentCell = animeCellList[indexPath.row]
        let currentCellAnimeName = animeViewModel.rewriteAnimeName(index: indexPath.row)
        
        cell.setUpAnimeName(name: currentCellAnimeName)
        cell.setUpAnimeImage(imageURL: currentCell.animeImg)
        
        return cell
    }
}

extension AnimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeCellName = animeViewModel.getAnimeName(index: indexPath.row)
        coordinator?.goToAnimeFacts(path: animeCellName)
    }
}
