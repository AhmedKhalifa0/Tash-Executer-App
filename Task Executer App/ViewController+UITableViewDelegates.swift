//
//  ViewController+UITableViewDelegates.swift
//  Task Executer App
//
//  Created by Ahmed Khalifa on 08/07/2022.
//

import Foundation
import UIKit

// MARK: - UITableViewDataSource
extension ViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let task = tasks[indexPath.row]
        
        let attributedText = NSMutableAttributedString()
        let regularAttrs = [NSAttributedString.Key.font : UIFont(name: "ArialMT", size: 12)!]
        let boldAttrs = [NSAttributedString.Key.font : UIFont(name: "Arial-BoldMT", size: 12)!]
        let regularTaskDate = NSMutableAttributedString(string: task.date, attributes:regularAttrs)
        let boldTaskName = NSMutableAttributedString(string: task.taskName, attributes:boldAttrs)
        attributedText.append(regularTaskDate)
        attributedText.append(boldTaskName)
        cell.textLabel?.attributedText = attributedText
        return cell
    
    }
    
    
}
// MARK: - UITableViewDelegate
extension ViewController :UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
