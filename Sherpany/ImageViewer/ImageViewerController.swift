import UIKit

class ImageViewController: UIViewController {
    let imageView = UIImageView()
    var url: URL?
    
    convenience init(url: URL) {
        self.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.view.addSubview(imageView)
        view.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        imageView.contentMode = .scaleAspectFit
        if let url = url {
            ImageDataProvider.load(url: url) { [weak self] image, _ in
                self?.imageView.image = image
            }
        }
    }
    
    @objc func done() {
        dismiss(animated: true, completion: nil)
    }
}
