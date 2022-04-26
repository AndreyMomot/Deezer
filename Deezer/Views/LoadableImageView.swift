//
//  LoadableImageView.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import UIKit

final class LoadableImageView: UIImageView {
    
    private var currentTask: URLSessionTask?
    private lazy var activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var imageUrlString: String?
    
    init() {
        super.init(image: nil, highlightedImage: nil)
        
        activity.fill(in: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        activity.fill(in: self)
    }
    
    func loadImageWithUrl(urlString: String) {
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()
        
        imageUrlString = urlString
        
        image = nil
                
        // Load already cached image if so
        if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
            image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            activity.startAnimating()

            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) {[weak self] (data, response, error) in
                DispatchQueue.main.async {
                    self?.activity.stopAnimating()
                }

                if let error = error {
                    print(error)
                    return
                }
                
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async {
                        // Cache just loaded image
                        ImageCache.shared.save(image: downloadedImage, forKey: urlString)
                        if self?.imageUrlString == urlString {
                            self?.image = downloadedImage
                        }
                    }
                }
                
            }
            currentTask = dataTask
            dataTask.resume()
        }
    }
}
