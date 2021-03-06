import Fluent
import Vapor

struct LoginResponse: Content {
    let isSuccess: Bool
}

struct LoginRequestBody: Content {
    let username: String
    let password: String
}


struct SignUpResponse: Content {
    let isSuccess: Bool
}

struct SignUpRequestBody: Content {
    let username: String
    let email: String
    let password: String
}


func routes(_ app: Application) throws {
    
    // MARK:
    app.get("") { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }

    
    
    app.post("api", "v1", "login") { req -> LoginResponse in
        guard let bodyData = req.body.data else {
            throw Abort(.badRequest)
        }

        
        let decodedData = try JSONDecoder().decode(LoginRequestBody.self, from: bodyData)
        
        print(decodedData.password)
        let isValidUser = decodedData.username == "Nathan123"
        let isValidPassword = decodedData.password == "password123"
        let isSuccessLogin = isValidUser && isValidPassword
        
        return LoginResponse(isSuccess: isSuccessLogin)
    }
    
    
    app.post("api", "v1", "signup") { req -> SignUpResponse in
        guard let bodyData = req.body.data else {
            throw Abort(.badRequest)
        }

        
        let decodedData = try JSONDecoder().decode(SignUpRequestBody.self, from: bodyData)
        
        // il faudrait enregistrer l'utilisateur dans la base de donnée
        
        // let userController = UserController()
        // userController.create(req: req)
        
        
        
        return SignUpResponse(isSuccess: true)
    }

    try app.register(collection: UserController())
}
