//
//  SecondViewController.swift
//  keyb13
//
//  Created by Артём Коротков on 15.01.2023.
//

import UIKit

final class SecondViewController: UIViewController {
    static let shared = SecondViewController()
    
    //MARK: - Private properties
    private let imageView: NotesView = {
        let image = NotesView()
        return image
    }()
    
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    // MARK: - Private Methods
    private func getInfoAboutNotes(size: UInt8) {
        print(size)
    }
    
    private func setupView() {
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
