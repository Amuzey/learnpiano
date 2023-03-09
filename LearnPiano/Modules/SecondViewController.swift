//
//  SecondViewController.swift
//  keyb13
//
//  Created by Артём Коротков on 15.01.2023.
//

import UIKit

class SecondViewController: UIViewController {
    static let shared = SecondViewController()

    private let imageView: NotesView = {
         let image = NotesView()
         return image
     }()
    
    func getInfoAboutNotes(size: UInt8) {
        print(size)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    func setupView() {
        title = "Second View Controller"
        view.backgroundColor = .lightText
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(200)
            make.top.equalToSuperview().inset(200)
            make.width.equalToSuperview()
        }
    }
}
