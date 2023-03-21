//
//  MusicList.swift
//  LearnPiano
//
//  Created by Алексей on 21.03.2023.
//

import UIKit

class MusicList: UITableView {

}

extension MusicList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Music", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Здесь будет отображаться название добавленной композиции"
        cell.contentConfiguration = content
        
        return cell
    }
}

extension MusicList: UITableViewDelegate {
    
}
