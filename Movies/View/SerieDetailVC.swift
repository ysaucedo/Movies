//
//  ShowDetailVC.swift
//Movies Yair
//
//  Created by Yair Saucedo on 20/11/21.
//

import UIKit
import WebKit

class SerieDetailVC: UIViewController {
    
    var viewModel = ViewModelSerieDetail()
    var show:Serie!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var imdbBtn: UIButton!
    @IBOutlet weak var collectionVideos: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bind()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    private func configureView() {
        navigationItem.title = show!.name
        summaryLbl.text = show.overview
        
        imdbBtn.addTarget(self, action: #selector(goImdb), for: .touchUpInside)
        imdbBtn.isHidden = false
        
        collectionVideos.delegate = self
        collectionVideos.dataSource = self
        collectionVideos.isHidden = true
        
        viewModel.retriveData(id: show.id, completion: {
            (respuesta) in
            if (respuesta != nil) {
                let shareMenu = UIAlertController(title: nil, message: "Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?", preferredStyle: .alert)
                let aceptAction = UIAlertAction(title: "Reintentar", style: .default, handler:  { action in
                    self.configureView()
                })
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                shareMenu.addAction(aceptAction)
                shareMenu.addAction(cancelAction)
                DispatchQueue.main.async {
                    self.present(shareMenu, animated: true, completion: nil)
                }
            }
        })



        if #available(iOS 11.0, *) {
            titleLbl.stylLbl(show.original_language, fonts.nExtraBold, colors.blue, 17)
            ratingLbl.stylLbl(String(show.vote_average), fonts.nExtraBold, colors.blue, 17)
            let webView = WKWebView()
            //webView.frame = CGRect(x: 0,y: 0,width: 100,height: 100)
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.loadHTMLString("<meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=YES\">\(show.overview)", baseURL: nil)
            self.view.addSubview(webView)
            NSLayoutConstraint.activate([
                    webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    webView.topAnchor.constraint(equalTo:  self.collectionVideos.bottomAnchor, constant: 8.0),
                    webView.rightAnchor.constraint(equalTo: view.rightAnchor),
                    webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        } else {
            // Fallback on earlier versions
            titleLbl.text = show.original_language
            ratingLbl.text = String(show.overview)
            let webView = UIWebView()
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.loadHTMLString("<meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=YES\">\(show.overview)", baseURL: nil)
            self.view.addSubview(webView)
            NSLayoutConstraint.activate([
                    webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    webView.topAnchor.constraint(equalTo:  self.collectionVideos.bottomAnchor, constant: 8.0),
                    webView.rightAnchor.constraint(equalTo: view.rightAnchor),
                    webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        }
        
        
        if let poster_path = show.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w342/\(poster_path)")
            image.kf.setImage(with: url)
        }else{
            if #available(iOS 13.0, *) {
                image.image = UIImage(systemName: "nosign")
            } else {
                // Fallback on earlier versions
            }
        }
                
    }
    
    
    @objc func goImdb() {
        if let url = URL(string: "https://www.themoviedb.org/movie/\(show.id)") {
            UIApplication.shared.open(url)
        }
    }
    
    
    private func bind() {
 
        viewModel.refreshData = { [weak self] () in
            
            DispatchQueue.main.async {
                self?.collectionVideos.isHidden = false
                self?.collectionVideos.reloadData()
                //self?.activityIndicator.stopAnimating()
                //self?.activityIndicator.isHidden = true
            }
            
        }
    }
        
}

extension SerieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.dataArray.count)
        return viewModel.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCollectionViewCell
        
        let video:Video = viewModel.dataArray[indexPath.row]
        let url = URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
            
        cell.imageViewVideo?.kf.setImage(with: url)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video:Video = viewModel.dataArray[indexPath.row]
        if let url = URL(string: "https://www.youtube.com/watch?v=\(video.key)") {
            UIApplication.shared.open(url)
        }
    }
    
}
