//
//  ContentView.swift
//  BookFinder
//
//  Created by Василий Буланов on 17.05.2022.
//

import Vision
import SwiftUI

struct ContentView: View {
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var imageText = "image text"
    var body: some View {
        VStack {
            Button(action: {
                showSheet.toggle()
            }, label: {
                Label("Scan Image", systemImage: "camera.viewfinder")
            })
//            Button(action: {
//                recognizeText(image: image)
//            }, label: {
//                Text("Recognize")
//            })
            Image(uiImage: self.image)
                .resizable()
                .frame(width: 200, height: 200)
                .background(.gray)
            Text(imageText)
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                .onDisappear {
                    recognizeText(image: image)
                }
        }
    }
    
    private func recognizeText(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        //Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        //Request
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: "\n")
            
            DispatchQueue.main.async {
                self.imageText = text
            }
        }
        //Process request
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
