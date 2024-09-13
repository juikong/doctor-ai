//
//  HomeView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
#if os(iOS)
                Spacer()
                NavigationLink(destination: HomeOneView()) {
                    VStack {
                        Image(systemName: "doc.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Text("Take Photo")
                            .font(.title)
                    }
                    .padding()
                    .frame(maxWidth: 300)
                }
                .foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
                .background(Color(.lightGray))
                .cornerRadius(30)
                Spacer()
                NavigationLink(destination: HomeTwoView()) {
                    VStack {
                        Image(systemName: "doc.badge.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Text("Upload File")
                            .font(.title)
                    }
                    .padding()
                    .frame(maxWidth: 300)
                }
                .foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
                .background(Color(.lightGray))
                .cornerRadius(30)
                Spacer()
#else
                Spacer()
                NavigationLink(destination: HomeTwoView()) {
                    VStack {
                        Image(systemName: "doc.badge.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                        Text("Upload File")
                    }
                    .padding()
                    .frame(maxWidth: 100)
                }
                Spacer()
#endif
            }
            .padding()
            .navigationTitle("Import")
        }
    }
}

func recognizeTextUsingAzure(url: URL, completion: @escaping ([String]) -> Void) {
    let endpoint = "https://medicalreportextraction.cognitiveservices.azure.com"
    let apiVersion = "2023-07-31"
    let apiKey = "66815bb015484fb39ed60ee6db6ef6eb"

    guard let fileData = try? Data(contentsOf: url) else {
        print("Failed to load file data")
        completion([])
        return
    }

    let base64String = fileData.base64EncodedString()

    guard let apiUrl = URL(string: "\(endpoint)/formrecognizer/documentModels/prebuilt-document:analyze?api-version=\(apiVersion)") else {
        print("Invalid URL")
        completion([])
        return
    }

    var request = URLRequest(url: apiUrl)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")

    let requestBody: [String: Any] = [
        "base64Source": base64String
    ]

    guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
        print("Failed to serialize JSON")
        completion([])
        return
    }

    request.httpBody = httpBody

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion([])
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            print("No HTTP response received")
            completion([])
            return
        }

        if httpResponse.statusCode != 202 {
            print("HTTP Response Headers: \(httpResponse.allHeaderFields)")
            print("Failed with status code: \(httpResponse.statusCode)")
            completion([])
            return
        }

        guard data != nil else {
            print("No data received")
            completion([])
            return
        }

        // Extract the apim-request-id from the headers
        if let requestId = httpResponse.allHeaderFields["apim-request-id"] as? String {
            print("apim-request-id: \(requestId)")
            // Perform GET request with the requestId
            fetchAnalysisResult(requestId: requestId, endpoint: endpoint, apiKey: apiKey, apiVersion: apiVersion, completion: completion)
        } else {
            print("apim-request-id not found in response headers")
            completion([])
        }
        
        
    }.resume()
}

func fetchAnalysisResult(requestId: String, endpoint: String, apiKey: String, apiVersion: String, completion: @escaping ([String]) -> Void) {
    // Adding delay of 15 seconds before fetching the analysis result
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
        guard let resultUrl = URL(string: "\(endpoint)/formrecognizer/documentModels/prebuilt-document/analyzeResults/\(requestId)?api-version=\(apiVersion)") else {
            print("Invalid URL for fetching analysis result")
            completion([])
            return
        }

        var request = URLRequest(url: resultUrl)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching analysis result: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received")
                completion([])
                return
            }

            // Print raw data for debugging
            //let responseString = String(data: data, encoding: .utf8) ?? "Failed to convert data to string"
            //print("Raw Response Data: \(responseString)")

            // Parse JSON response
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    //print("Azure response: \(jsonResponse)")

                    var extractedText = ""
                    if let analyzeResult = jsonResponse["analyzeResult"] as? [String: Any],
                       let readResults = analyzeResult["content"] as? String {
                        extractedText = readResults
                        
                    }
                    let newlines = CharacterSet.newlines
                    let recognized = extractedText.components(separatedBy: newlines)

                    completion(recognized)
                } else {
                    print("Failed to parse JSON response")
                    completion([])
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion([])
            }
        }.resume()
    }
}

#Preview {
    HomeView()
}
