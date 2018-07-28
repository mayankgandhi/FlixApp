//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Mayank Gandhi on 27/07/18.
//  Copyright © 2018 Mayank Gandhi. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var reloadIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        reloadIndicator.startAnimating()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPulltoRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
       
        fetchMovies()
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didPulltoRefresh(_ refreshControl: UIRefreshControl)
    {
        fetchMovies()
    }
    
    func fetchMovies()
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.reloadIndicator.stopAnimating()
                for movie in movies
                {
                    let title = movie["title"] as! String
                    print(title)
                }
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCellTableViewCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        tableView.rowHeight = UITableViewAutomaticDimension
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        let PosterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let PosterURL = URL(string: baseURLString + PosterPathString)!
        cell.posterImageView.af_setImage(withURL: PosterURL)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell)
        {
            let movie = movies[indexPath.row]
            let detailview = segue.destination as! detailViewController
            detailview.movie = movie
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
