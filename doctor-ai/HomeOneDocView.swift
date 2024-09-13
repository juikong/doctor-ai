//
//  HomeOneDocView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 28/07/2024.
//

#if os(iOS)
import SwiftUI
import VisionKit
import PDFKit

struct HomeOneDocView: UIViewControllerRepresentable {
    var onComplete: ((URL?) -> Void)?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onComplete: onComplete)
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var onComplete: ((URL?) -> Void)?
        
        init(onComplete: ((URL?) -> Void)?) {
            self.onComplete = onComplete
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            controller.dismiss(animated: true, completion: nil)
            
            let pdfDocument = PDFDocument()
            
            for pageIndex in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                if let pdfPage = PDFPage(image: image) {
                    pdfDocument.insert(pdfPage, at: pageIndex)
                }
            }
            
            let url = savePDF(pdfDocument: pdfDocument)
            onComplete?(url)
        }
        
        func savePDF(pdfDocument: PDFDocument) -> URL? {
            let filename = getDocumentsDirectory().appendingPathComponent("scan.pdf")
            if pdfDocument.write(to: filename) {
                print("Saved to \(filename)")
                return filename
            } else {
                print("Failed to save PDF")
                return nil
            }
        }
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<HomeOneDocView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<HomeOneDocView>) {
    }
}
#endif
