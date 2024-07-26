//
//  RMCharacterPhotoCollectionViewCell.swift
//  RAndM
//
//  Created by mac on 2024/7/22.
//

import Foundation
final class RMCharacterPhotoCollectionViewCellViewModel {
    private let imageURL: URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    public func fetchImage(completion:@escaping(Result<Data, Error>) -> Void) {
        guard let imageURL = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(imageURL) { result in
            completion(result)
        }
    }
    

}
