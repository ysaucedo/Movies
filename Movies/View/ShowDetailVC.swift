//
//  ShowDetailVC.swift
//Movies Yair
//
//  Created by Yair Saucedo on 20/11/21.
//

import UIKit
import WebKit

class ShowDetailVC: UIViewController {
    
    var viewModel = ViewModelDetail()
    var show:Show!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var backdrop: UIImageView!
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
        
        navigationItem.title = show!.title
        summaryLbl.text = show.overview
        
        backdrop.bottomCurveS()
        
        image.shadow(shadowRadius: 5.0, shadowOpacity: 0.5, shadowOffset: CGSize(width: 5, height: 5))
        
        imdbBtn.addTarget(self, action: #selector(goImdb), for: .touchUpInside)
        imdbBtn.isHidden = false
                
        collectionVideos.delegate = self
        collectionVideos.dataSource = self
        collectionVideos.isHidden = true
        
        viewModel.retriveData(id: show.id, completion: {[weak self]
            (respuesta) in
            if (respuesta != nil) {
                let shareMenu = UIAlertController(title: nil, message: "Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?", preferredStyle: .alert)
                let aceptAction = UIAlertAction(title: "Reintentar", style: .default, handler:  { action in
                    self!.configureView()
                })
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                shareMenu.addAction(aceptAction)
                shareMenu.addAction(cancelAction)
                DispatchQueue.main.async {
                    self!.present(shareMenu, animated: true, completion: nil)
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
            let url = URL(string: "\(urls.regularImageBaseURLString)/\(poster_path)")
            image.kf.setImage(with: url)
        }else{
            if #available(iOS 13.0, *) {
                image.image = UIImage(systemName: "nosign")
            } else {
                // Fallback on earlier versions
            }
        }
               
        if let backdrop_path = show.backdrop_path {
            let url = URL(string: "\(urls.backdropImageBaseURLString)/\(backdrop_path)")
            backdrop.kf.setImage(with: url)
        }
        
    }
    
    @objc func goImdb() {
        if let url = URL(string: "\(urls.themoviedbBaseURLString)/movie/\(show.id)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func setFavorite(sender: UIBarButtonItem){
        
        show.adult = !show.adult

        do{
            try self.context.save()
        } catch {
            print("error  \(error.localizedDescription) ")
        }
    }
    
    private func bind() {
 
        viewModel.refreshData = { [weak self] () in
            
            DispatchQueue.main.async {
                self?.collectionVideos.isHidden = false
                self?.collectionVideos.reloadData()
            }
            
        }
    }
        
}

extension ShowDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.dataArray.count)
        return viewModel.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCollectionViewCell
        
        let video:Video = viewModel.dataArray[indexPath.row]
        let url = URL(string: "\(urls.youtubeImgBaseURLString)/vi/\(video.key)/hqdefault.jpg")
            
        cell.imageViewVideo?.kf.setImage(with: url)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video:Video = viewModel.dataArray[indexPath.row]
        if let url = URL(string: "\(urls.youtubeBaseURLString)/watch?v=\(video.key)") {
            UIApplication.shared.open(url)
        }
    }
    
}
