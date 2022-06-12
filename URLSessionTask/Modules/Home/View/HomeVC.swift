//
//  HomeVC.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: BaseController<HomeViewModel> {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureTableView()
    }

    override func bind(viewModel: HomeViewModel) {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailTextFieldBehavior)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordTextFieldBehavior)
            .disposed(by: disposeBag)
        
        viewModel.isSendButtonEnable
            .subscribe { [weak self] (isEnable) in
                guard let self = self,
                let isEnable = isEnable.element else{ return }
                self.sendBtn.isEnabled = isEnable
                if isEnable { self.sendBtn.backgroundColor = .systemPink }
                else { self.sendBtn.backgroundColor = .gray }
        }.disposed(by: disposeBag)
        
        sendBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else{ return }
                //Handle action here...
                print("Handle action here...")
                self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(nibWithClass: ImageCell.self)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.photosObservable
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: ImageCell.self),
                                         cellType: ImageCell.self)) { (index, model, cell) in
                cell.bind(model)
            }.disposed(by: disposeBag)
    }

}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
