//
//  ViewController.swift
//  closure_enums_delegates
//
//  Created by David Martinez-Lebron on 6/28/18.
//  Copyright © 2018 davaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()
    var jobs = [Job]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getJobs(closure: { [unowned self] (result) in
            switch result {
            case .error(let error):
                print(error)
            case .jobs(let jobs):
                self.jobs = jobs
                self.tableView.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = jobs[indexPath.row].company
        cell.detailTextLabel?.text = "Location: \(jobs[indexPath.row].location ?? "N/A")"
        return cell
    }
}

