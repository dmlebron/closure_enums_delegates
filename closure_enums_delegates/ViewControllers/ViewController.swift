//
//  ViewController.swift
//  closure_enums_delegates
//
//  Created by David Martinez-Lebron on 6/28/18.
//  Copyright © 2018 davaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var viewModel = ViewModel(delegate: self)
    var jobs = [Job]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getJobs()
    }
}

extension ViewController: ViewModelDelegate {

    func didFinishLoadingWithJobs(_ jobs: [Job]?) {
        guard let jobs = jobs else { return }
        self.jobs = jobs
        tableView.reloadData()
    }

    func didFailedWithError(_ error: ViewModelError) {
        print(error)
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
        cell.detailTextLabel?.text = "Location: \(jobs[indexPath.row].location)"
        return cell
    }
}

