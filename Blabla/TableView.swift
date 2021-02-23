//
//  TableView.swift
//  Blabla
//
//  Created by Robert Pervushen on 05.02.2021.
//

import UIKit



class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        
        tableViewScore.alwaysBounceVertical = false
        super.viewDidLoad()
        tableViewScore.dataSource = self
        tableViewScore.delegate = self
        TableView.scoreForThis.append(String(ViewControllerAnother.temp))
//        ViewController.score.append(String(y))
        
        
//        ViewController.score = scoreForThis
        

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool){
        
        super.viewDidDisappear(false)
        TableView.scoreForThis = ViewController.score
        
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(true)
        TableView.scoreForThis = ViewController.score
    }
    
    @IBOutlet weak var tableViewScore: UITableView!
    static var scoreForThis = [String]()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableView.scoreForThis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForScore", for: indexPath)
        
        cell.textLabel!.text = TableView.scoreForThis[indexPath.row]
        return cell
    }
    
}
