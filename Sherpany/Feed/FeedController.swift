import UIKit

protocol FeedControllerDelegate: class {
    func postSelected(post: PostId)
}

final class FeedController: UITableViewController, StoryboardLoadable {
    var dataProvider: FeedDataProviding!
    weak var delegate: FeedControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Table DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfItems
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath)
        let model = dataProvider.model(at: indexPath.row)
        (cell as? PostCell)?.setup(with: model)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataProvider.delete(at: indexPath.row)
        }
    }
    
    // MARK: - Table Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = dataProvider.id(at: indexPath.row)
        delegate?.postSelected(post: post)
    }
}

private extension FeedController {
    // MARK: - Private functions
    
    func setup() {
        tableView.register(UINib(nibName: PostCell.identifier, bundle: nil),
                           forCellReuseIdentifier: PostCell.identifier)
        getFeed()
        setupSearch()
    }
    
    func setupSearch() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
    }

    func getFeed() {
        dataProvider.setup()
        tableView.reloadData()
    }
}

extension FeedController: FeedDataProviderDelegate {
    func didChange(diff: CollectionDifference<Any>) {
        DispatchQueue.main.async {
            self.tableView.applyChanges(diff: diff)
        }
    }
}

extension FeedController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dataProvider.search(text: searchController.searchBar.text ?? "")
    }
}
