//
//  PDFViewController.swift
//  DownloadPDF
//
//  Created by Natanael Simri Alvarez Guzman on 5/11/22.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    private var path: URL?

    init(withPath path: URL){
        self.path = path
        super.init(nibName: String(describing: PDFViewController.self), bundle: Bundle(for: PDFViewController.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = path, let pdfDocument = PDFDocument(url: path) {
            pdfView.displayMode = .singlePageContinuous
            pdfView.autoScales = true
            pdfView.displayDirection = .vertical
            pdfView.document = pdfDocument
        }
    }
    
}
