//
//  HomeVC.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import UIKit

class HomeVC: BaseController<HomeViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func bind(viewModel: HomeViewModel) {
        
    }


}
