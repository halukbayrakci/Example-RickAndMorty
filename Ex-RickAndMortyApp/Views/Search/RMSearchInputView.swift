//
//  RMSearchInputView.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 18.09.2023.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearchText text: String)
    func rmSearchInputViewDidTapSearchKeyboardButton(_ inputView: RMSearchInputView)
}

///  View for top part of search screen with search bar
final class RMSearchInputView: UIView {
    
    weak var delegate: RMSearchInputViewDelegate?
    
    private let searchbar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }

    private var stackView: UIStackView?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false 
        addSubview(searchbar)
        addConstraint()
        
        searchbar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Private
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            searchbar.topAnchor.constraint(equalTo: topAnchor),
            searchbar.leftAnchor.constraint(equalTo: leftAnchor),
            searchbar.rightAnchor.constraint(equalTo: rightAnchor),
            searchbar.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    
    private func createOptionStackView() -> UIStackView {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchbar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return stackView
    }
    
    private func createOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
       
        let stackView = createOptionStackView()
        self.stackView = stackView
        for x in 0..<options.count {
            let option = options[x]
            let button = createButton(with: option, tag: x)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(with option: RMSearchInputViewViewModel.DynamicOption, tag: Int) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: option.rawValue,  attributes: [ .font : UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.label ]), for: .normal)
        
        button.backgroundColor = .secondarySystemFill
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.tag = tag
        button.layer.cornerRadius = 6
        
        return button
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else {
            return
        }
        let tag = sender.tag
        let selected = options[tag]
        
        delegate?.rmSearchInputView(self, didSelectOption: selected)
    }
    
    //MARK: - Public
    
    public func configure(with viewModel: RMSearchInputViewViewModel) {
        searchbar.placeholder = viewModel.searchPlaceHolderText
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        searchbar.becomeFirstResponder()
    }
    
    public func update(option: RMSearchInputViewViewModel.DynamicOption, value: String) {
        // Update options
        guard let buttons = stackView?.arrangedSubviews as? [UIButton], let allOptions = viewModel?.options, let index = allOptions.firstIndex(of: option) else {
            return
        }
        buttons[index].setAttributedTitle(NSAttributedString(string: value.uppercased(), attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.link]), for: .normal)
    }
}

// MARK: - UISearchBarDelegate

extension RMSearchInputView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Notify delegate of change text
        delegate?.rmSearchInputView(self, didChangeSearchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Notify that search button was tapped
        searchBar.resignFirstResponder()
        delegate?.rmSearchInputViewDidTapSearchKeyboardButton(self)
    }
}
