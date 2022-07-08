//
//  ViewController.swift
//  Task Executer App
//
//  Created by Ahmed Khalifa on 08/07/2022.
//

import UIKit
class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tasksStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var task1Btn: UIButton!
    @IBOutlet weak var task2Btn: UIButton!
    @IBOutlet weak var task3Btn: UIButton!
    @IBOutlet weak var task4Btn: UIButton!
    
    
    // MARK: - Attributes
    var tasks :[MyTask] = []
    var taskButtons : [UIButton] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskButtons = [task1Btn,task2Btn,task3Btn,task4Btn]
        setupUI()
    }
    
    // MARK: - UI
    func setupUI(){
        setupTableView()
        setupButtonsTags()
        roundedCornerWithBorder(customView: tableView)
        roundedCornerWithBorder(customView: tasksStack)
        
    }
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
    
   
    func setupButtonsTags(){
        task1Btn.tag = 1
        task2Btn.tag = 2
        task3Btn.tag = 3
        task4Btn.tag = 4
        
    }
    
    func roundedCornerWithBorder(customView:UIView){
        customView.clipsToBounds = true
        customView.layer.cornerRadius = 5
        customView.layer.borderColor = UIColor(red: 0.90, green: 0.91, blue: 0.91, alpha: 1.00).cgColor
        customView.layer.borderWidth = 1
    }
    
    
    func disableAllButtons(){
            self.taskButtons.forEach {
                $0.backgroundColor = .white
                $0.setTitleColor(.black, for: .normal)
            }
        

    }
}



// MARK: - Actions
extension ViewController{
    
    @IBAction func  taskButtonTapped(sender: AnyObject) {
        guard let button = sender as? UIButton else { return }
        let tag = button.tag
        DispatchQueue.global(qos: .userInitiated).async {
            // Change buttons colors
            DispatchQueue.main.async {
                self.disableAllButtons()
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
            }
            // Excute task
            self.excuteTask(task: "Task \(tag)")
        }
    }
    
    
    func excuteTask(task:String){
        // Download large size image
            if let url = URL(string: "https://images.unsplash.com/photo-1550330562-b055aa030d73?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80") {
                if let _ = try? Data(contentsOf: url) {
                    self.tasks.append(MyTask(taskName: task, date: " \(Date()) "))
                    reloadTableView()
                    return
                }
            }
        
    }
    
    
    func reloadTableView(){
        let group = DispatchGroup()
        // 1 reload tableView
        group.enter()
        DispatchQueue.main.async  {
            self.tableView.reloadData()
            group.leave()
        }
        // 2 reload Scroll to last row
        group.enter()
            DispatchQueue.main.async  {
            let indexPath = IndexPath(row: self.tasks.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            group.leave()
        }
    }
}
