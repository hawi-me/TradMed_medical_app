package route

// import (
//     "time"
//     "tradmed/config"
//     "tradmed/database"
//     "tradmed/delivery/controller"
//     "tradmed/repository"
//     "tradmed/usecase"

//     "github.com/gin-gonic/gin"
// )

// func UserRouter(env *config.Env, timeout time.Duration, db database.Database, router *gin.RouterGroup) {
//     userRepo := repository.NewUserRepository(db, "users")
//     userController := &controller.UserController{
//         UserUseCase: usecase.NewUserUseCase(userRepo, timeout),
//         Env:         env,
//     }

//     router.POST("/signup/email/username", userController.Signup)
// }
