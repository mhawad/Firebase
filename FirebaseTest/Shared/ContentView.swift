//
//  ContentView.swift
//  Shared
//
//  Created by Mirna Sokar on 6/9/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var username = ""
    @State var usernames: [String] = []
    
    
    @State var notification = ""
    @State var notifications: [String] = []
    
    var body: some View {
        
        //displaying users
        VStack{
            HStack {
                TextField("Enter your name", text: $username)

                Button(action: {upload() }){
                    Text("Upload")
                }
            }.onAppear(perform: {
              download()
            })
            
            List(0..<usernames.count, id: \.self) { i in
                Text(usernames[i])
                
            }
        }
        
      //displaying notes
        VStack{
            HStack {
                TextField("Enter your note", text: $notification)

                Button(action: {uploadNotes()}){
                    Text("Upload Notification")
                }
            }.onAppear(perform: {
              downloadNotes()
            })
            
            List(0..<notifications.count, id: \.self) { i in
                Text(notifications[i])
                
            }
        }
        
        
        
        
    }
    
    
    //upload users
    func upload() {
        let db = Firestore.firestore()
        db.collection("users").document().setData(["username": username])
    }
    
    //download users
    func download() {
        let db = Firestore.firestore()
        db.collection("users").addSnapshotListener{(snap, err) in
            if err != nil{
                print("There is an Error")
                return
            }
            for i in snap!.documentChanges{
                let documentId = i.document.documentID
                let username = i.document.get("username")
                DispatchQueue.main.async {
                    usernames.append("\(username)")
                    print(username)
                }
            }
        }
    }
        
        
    
 //upload notes
        func uploadNotes() {
            let db = Firestore.firestore()
            db.collection("notes").document().setData(["notification": notification])
        }
        
    //download notes
    func downloadNotes() {
        let db = Firestore.firestore()
        db.collection("notes").addSnapshotListener{(snap, err) in
            if err != nil{
                print("There is an Error")
                return
            }
            for i in snap!.documentChanges{
                let documentId = i.document.documentID
                let notification = i.document.get("notification")
                DispatchQueue.main.async {
                    notifications.append("\(notification)")
                    print(notification)
                }
            }
        }
    }
    
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
