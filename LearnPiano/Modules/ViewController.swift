//
//  ViewController.swift
//  LearnPiano
//
//  Created by Alexey Nikiforov on 20.01.2023.
//

import UIKit
import AudioKit
import SnapKit
import MobileCoreServices
import UniformTypeIdentifiers

final class ViewController: UIViewController, UITableViewDelegate {
    //MARK: - Private properties
    private let keyboard = Keyboard()
    private let visualAssistans = VisualAssistans()
    private let soundPlayer = SoundPlayer()
    private let controlPanel = ControlPanel()
    private let musicList = MusicList()
    private let button = UIButton()
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
        setupViewAssistans()
        setupSoundPlayer()
        setupAddButton()
        setupControlPanel()
        setupMusicList()
    }
    
    //MARK: - Action
    @objc func addData() {
        showAlert(with: "Добавить композицию", and: "Выберите 'MIDI' файл, который вы хотите загрузить в приложение.")
    }
    
    //MARK: - Private methods
    private func setupKeyboard() {
        view.addSubview(keyboard)
        keyboard.delegate = visualAssistans
        keyboard.delegate2 = soundPlayer
        keyboard.backgroundColor = .lightGray
        keyboard.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupViewAssistans() {
        view.addSubview(visualAssistans)
        visualAssistans.delegate = keyboard
        visualAssistans.backgroundColor = .darkGray
        visualAssistans.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(keyboard.snp_topMargin)
            make.height.equalTo(view.bounds.height / 3)
        }
    }
    
    private func setupSoundPlayer() {
        view.addSubview(soundPlayer)
        soundPlayer.delegate = visualAssistans
        soundPlayer.backgroundColor = .lightGray
        soundPlayer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(visualAssistans.snp_topMargin)
            make.height.equalTo(120)
        }
    }
    
    private func setupMusicList() {
        musicList.dataSource = musicList
        musicList.register(UITableViewCell.self, forCellReuseIdentifier: "Music")
        view.addSubview(musicList)
        musicList.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(controlPanel.snp_bottomMargin)
            make.bottom.equalTo(button.snp_topMargin)
        }
    }
    
    private func setupAddButton() {
        view.addSubview(button)
        button.backgroundColor = .gray
        button.setTitle("Добавь композицию...", for: .normal)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(soundPlayer.snp_topMargin)
            make.height.equalTo(80)
        }
        button.addTarget(self, action: #selector(addData), for: .touchUpInside)
    }
    
    private func setupControlPanel() {
        view.addSubview(controlPanel)
        controlPanel.keyboardDelegate = keyboard
        controlPanel.delegate = visualAssistans
        controlPanel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp_topMargin)
            make.height.equalTo(100)
        }
    }
}

//MARK: - UIAlertController
extension ViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let addLeftTrack = UIAlertAction(title: "Левая рука", style: .default) { _ in
            self.importFile()
        }
        let addRightTrack = UIAlertAction(title: "Правая рука", style: .default) { _ in
            print("добавить Правый")
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(addLeftTrack)
        alert.addAction(addRightTrack)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}

//MARK: - UIDocumentPickerDelegate
extension ViewController: UIDocumentPickerDelegate {
    private func importFile() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.midi], asCopy: true)
                documentPicker.delegate = self
                present(documentPicker, animated: true, completion: nil)
            }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard urls.first != nil else { return }
        // Handle the selected file here, for example by reading its contents or copying it to the app's file system
    }
}
