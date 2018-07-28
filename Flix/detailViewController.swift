//
//  detailViewController.swift
//  Flix
//
//  Created by Mayank Gandhi on 28/07/18.
//  Copyright © 2018 Mayank Gandhi. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    enum MovieKeys{
        static let title = "title"
        static let releaseDate = "release_date"
        static let overview = "overview"
        static let posterpath = "poster_path"
        static let backdroppath = "backdrop_path"
    }
    
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var postermovie: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie
        {
            titleLabel.text = movie[MovieKeys.title] as? String
            releasedateLabel.text = movie[MovieKeys.releaseDate] as? String
            overviewLabel.text = movie[MovieKeys.overview] as? String
            let backdropPathString = movie[MovieKeys.backdroppath] as! String
            let posterPathString = movie[MovieKeys.posterpath] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURLString+backdropPathString)!
            let posterpathURL = URL(string: baseURLString+posterPathString)!
            backdrop.af_setImage(withURL: backdropURL)
            postermovie.af_setImage(withURL: posterpathURL)
            
        }
        

        // Do any additional setup after loading the view.
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
