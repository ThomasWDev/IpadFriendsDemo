//
//  FriendsViewController.swift
//
//  Created by Thomas Woodfin on 5/19/21.
//

import UIKit

protocol FriendsViewControllerDelegate: class {
    
    func didSelectPhoto(_ photo: User)
}

class FriendsViewController: UIViewController {
    
    enum State {
        case start
        case empty
        case loading
        case friends
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    weak var delegate: FriendsViewControllerDelegate?
    
    private var friends = [User]()

    private let networkManager = NetworkManager()
    private var userRepository : UserRepository?

    
    init() {
        userRepository = UserRepository(networkManager: networkManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI() {

        title = NSLocalizedString("Friends", comment: "")
        extendedLayoutIncludesOpaqueBars = true
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: String(describing: UserCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: UserCell.self))
        collectionView.keyboardDismissMode = .onDrag
        
        setViewState(state: .start)
    }
    
    func setViewState(state: State) {
        switch state {
        case .start:
            collectionView.isHidden = true
            loadingIndicator.isHidden = true
            actionLabel.isHidden = false
            actionLabel.text = NSLocalizedString("Nothing to display.", comment: "")
        case .loading:
            collectionView.isHidden = true
            loadingIndicator.isHidden = false
            actionLabel.isHidden = true
        case .empty:
            collectionView.isHidden = true
            loadingIndicator.isHidden = true
            actionLabel.isHidden = false
            actionLabel.text = NSLocalizedString("No friends found.", comment: "")
        case .friends:
            collectionView.isHidden = false
            loadingIndicator.isHidden = true
            actionLabel.isHidden = true
        }
    }

    func setState(state: State) {
        setViewState(state: state)
    }

    func setFriends(_ friends: [User]) {
        self.friends = friends
        collectionView.reloadData()
    }

    func fetchFriends() {
        self.setState(state: .loading)
        userRepository!.fetchFriends(completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let friends):
                    self.setState(state: friends.isEmpty ? FriendsViewController.State.empty: .friends)
                    self.setFriends(friends)
                case .failure(let error):
                    self.setState(state: .empty)
                    self.showAlert(title: NSLocalizedString("Photo Error", comment: ""), message: error.localizedDescription)
                }
            }
        })
    }
}

// MARK: - UITableViewDataSource

extension FriendsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = 4
        let width = Int(UIScreen.main.bounds.width)
        let side = width / columns
        let rem = width % columns
        let addOne = indexPath.row % columns < rem
        let ceilWidth = addOne ? side + 1 : side
        return CGSize(width: ceilWidth, height: side)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCell.self), for: indexPath) as! UserCell
        cell.configCellWith(user: friends[indexPath.row])
        return cell
    }

}


// MARK: - UITableViewDelegate

extension FriendsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let friendDetailVC = FriendDetailViewController(nibName: "FriendDetailViewController", bundle: nil)
        friendDetailVC.user = friends[indexPath.row]
        self.navigationController?.pushViewController(friendDetailVC, animated: true)
    }
}

extension UIViewController {

    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
