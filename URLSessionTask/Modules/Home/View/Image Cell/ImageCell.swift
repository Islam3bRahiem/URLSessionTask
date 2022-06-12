//
//  ImageCell.swift
//  URLSessionTask
//
//  Created by Rowaad on 12/06/2022.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak fileprivate var photoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func bind(_ viewModel: ImageCellViewModel) {
        let url = URL(string: viewModel.imageURL)!
        let data = try? Data(contentsOf: url)

        if let imageData = data {
            self.photoImage.image = UIImage(data: imageData)
        }

    }
    
}
