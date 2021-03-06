//
//  ViewController.swift
//  ReactantPrototyping
//
//  Created by Filip Dolnik on 16.02.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Reactant
import UIKit
import SnapKit
import RxSwift

final class ViewController: ControllerBase<Void, ExampleRootView> {
    override init() {
        super.init()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.hidesBarsOnTap = true
    }
}


final class ExampleRootView: ViewBase<Void, Void> {

//    private let labelInsideSafeArea = UILabel(text: "Hello Reactant!")
    private let tableView = SimpleCollectionView<SimpleCell>(reloadable: false)
    
    override func afterInit() {
        tableView.action
            .subscribe(onNext: {
                print($0)
            }).disposed(by: lifetimeDisposeBag)
    }
    
    override func update() {
        tableView.componentState = .items(["Test1", "Test2", "Test3"])
    }

    override func loadView() {
        children(
//            labelInsideSafeArea
            tableView
        )
        
        tableView.collectionView.allowsMultipleSelection = true
        tableView.collectionView.allowsSelection = true
        tableView.collectionViewLayout.estimatedItemSize = CGSize(1)
    }

    override func setupConstraints() {
//        labelInsideSafeArea.snp.makeConstraints { make in
//            make.left.equalTo(fallback_safeAreaLayoutGuide).offset(20)
//            make.top.equalTo(fallback_safeAreaLayoutGuide).offset(20)
//        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

final class SimpleCell: ControlBase<String, Void>, CollectionViewCell {
    
    override var actions: [Observable<Void>] {
        return [
            rx.controlEvent(.touchUpInside).asObservable()
        ]
    }
    
    private let label = UILabel()
    
    override func update() {
        label.text = componentState
    }
    
    override func loadView() {
        children(
            label
        )
        
        label.font = UIFont.System.regular[15]
    }
    
    override func setupConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func setSelected(_ selected: Bool) {
        backgroundColor = selected ? .red : .clear
    }
}
