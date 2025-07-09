//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import MBProgressHUD

final class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel
    
    lazy var root = HomeView()
    
    private let disposeBag = DisposeBag()
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = root
        
        root.pokemonCollectionView.delegate = self
        root.pokemonCollectionView.dataSource = self
        
        viewModel.fetchPokemons()
        
        navigationItem.title = "Pokémon"
        
        setupBindings()
        
        dismissKeyboardOnTap()
        
        root.searchBar.searchTextField.delegate = self
    }
    
    fileprivate func setupBindings() {
        viewModel.pokemonResult
            .asObservable()
            .compactMap { $0 } // unwrap optional
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success:
                    MBProgressHUD.hide(for: view, animated: true)
                    root.pokemonCollectionView.reloadData()
                    
                case .loading:
                    let hud = MBProgressHUD.showAdded(to: view, animated: true)
                    hud.label.text = "Loading Pokémon..."
                    
                case .failure(let errorMessage):
                    MBProgressHUD.hide(for: view, animated: true)
                    
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true)
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPokemonsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonCell.cellIdentifier,
            for: indexPath
        ) as? PokemonCell
        else { return UICollectionViewCell() }
        
        cell.model = viewModel.getSpecificPokemon(idx: indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = PokemonCell()
        cell.model = viewModel.getSpecificPokemon(idx: indexPath.item)
        
        cell.setNeedsLayout()
        let width = (root.pokemonCollectionView.frame.size.width - 24 * 3) / 2
        let height = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let size = CGSize(width: width, height: height)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadMoreIfNeeded(currentIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel.getSpecificPokemon(idx: indexPath.item)
        else { return }
        
        let vc = PokemonDetailViewController()
        vc.data = model
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let keyword = textField.text else { return true }
        
        viewModel.searchPokemons(keyword: keyword)
        
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        viewModel.searchPokemons(keyword: "")
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?) ?? ""
        let updatedText = currentText.replacingCharacters(in: range, with: string)

        if updatedText.isEmpty {
            // Trigger reset
            viewModel.searchPokemons(keyword: "")
        }

        return true
    }
}

extension HomeViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: UIImage(systemName: "house"))
    }
}

