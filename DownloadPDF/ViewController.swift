//
//  ViewController.swift
//  DownloadPDF
//
//  Created by Natanael Simri Alvarez Guzman on 5/11/22.
//

import UIKit
import Alamofire
import SafariServices
import PDFKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var pdfPathTextField: UITextField!
    @IBOutlet weak var progresView: UIProgressView!
    
    var pathDownloaded = ""
    
    let pathStatic = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("example.pdf")
    
    
    @IBAction func didTapDownloadOption(_ sender: Any){
        // Utilizar esto cuando quieres enviarle el nombre
//        downloadPdf(url: pdfPathTextField.text ?? "", name: "NuevoPdf")
        // Esto es para solo descargar
        downloadPdf(url: pdfPathTextField.text ?? "")
    }
    
    @IBAction func didTapSafariOption(_ sender: Any){
        guard let url = URL(string: pdfPathTextField.text ?? "") else { return }
        let controller = SFSafariViewController(url: url)
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func didTapPDFViewOption(_ sender: Any){
        let pdfViewController = PDFViewController(withPath: pathStatic)
        self.navigationController?.pushViewController(pdfViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.progresView.progress = 0
        pdfPathTextField.text = "https://infolibros.org/libros/otra-vuelta-de-tuerca-henry-james.pdf"
        
    }
    
    func downloadPdf(url: String, name: String){
        let downloadUrl: String = url
        print("* downloadUrl: \(downloadUrl)")
        let destinationPath: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
                let fileURL = documentsURL.appendingPathComponent("\(name).pdf")
            print("Se esta guardando en: \(fileURL)")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        AF.download(downloadUrl, to: destinationPath).response { response in
            switch response.result {
            case .success:
                print("sucess")
                break
            case .failure:
                print("failure")
                break
            }
        }
    }
    
    func downloadPdf(url: String){
        let downloadUrl: String = url
        print("* downloadUrl: \(downloadUrl)")
        AF.download(downloadUrl).responseData { response in
            print("response: \(response)")
            switch response.result{
            case .success(let data):
                print("data: \(data)")
                do {
                    try data.write(to: self.pathStatic, options: .atomic)
                    print("Se esta guardando en: \(self.pathStatic)")
                }catch{
                    print("Error while writting")
                }
                break
            case .failure:
                break
            }
        }
        
    }
}
