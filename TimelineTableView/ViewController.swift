//
//  ViewController.swift
//  TimelineTableView
//
//  Created by ram on 11/22/17.
//  Copyright © 2017 ram. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var datas = [
        "21st Dec 2017": [
            [
                "timeInfo": "11:30",
                "title": "Work",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at iaculis velit, eu ullamcorper ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam egestas porta convallis. Praesent vehicula justo vitae ex placerat, ut lobortis elit fringilla.",
                "timeRemaining": "10 mins"
            ],
            [
                "timeInfo": "15:30",
                "title": "Meeting",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at iaculis velit, eu ullamcorper ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam egestas porta convallis.",
                "timeRemaining": "120 mins"
            ],
            [
                "timeInfo": "13:30",
                "title": "Lunch With Friends",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "timeRemaining": "125 mins"
            ],
            [
                "timeInfo": "21:30",
                "title": "Meeting",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at iaculis velit, eu ullamcorper ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                "timeRemaining": "15 mins"
            ]
        ],
        "22nd Dec 2017": [
            [
                "timeInfo": "13:30",
                "title": "Lunch With Friends",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "timeRemaining": "125 mins"
            ],
            [
                "timeInfo": "21:30",
                "title": "Meeting",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at iaculis velit, eu ullamcorper ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                "timeRemaining": "15 mins"
            ],
            [
                "timeInfo": "14:30",
                "title": "Lunch With Friends",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                "timeRemaining": "125 mins"
            ],
            [
                "timeInfo": "22:30",
                "title": "Greeting",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at iaculis velit, eu ullamcorper ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                "timeRemaining": "15 mins"
            ]
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: nil)
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "timelineTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let value = datas[Array(datas.keys.sorted())[section]] {
            return value.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(datas.keys.sorted())[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.setNeedsLayout()
        view.backgroundColor = #colorLiteral(red: 0.9685459733, green: 0.9686813951, blue: 0.9685031772, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        if let values = datas[Array(datas.keys.sorted())[indexPath.section]]{
            let value = values[indexPath.row]
            if let timeInfo = value["timeInfo"], let title = value["title"], let description = value["description"], let timeRemaining = value["timeRemaining"] {
                cell.configureCellData(timeInfo: timeInfo, title: title, description: description, timeRemaining: timeRemaining, tag: "Apple")
            }
        }
        return cell
    }

}

