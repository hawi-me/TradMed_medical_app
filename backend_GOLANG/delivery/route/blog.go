package route

import (
	"time"
	"tradmed/config"
	"tradmed/database"
	"tradmed/delivery/controller"
	"tradmed/repository"
	"tradmed/usecase"

	"github.com/gin-gonic/gin"
)

func BlogRouter(env *config.Env, timeout time.Duration, db database.Database, router *gin.RouterGroup) {
	blogRepo := repository.NewBlogRepository(db, "blogs")
	signupRepo := repository.NewUserRepository(db, "users")

	blogController := &controller.BlogController{
		BlogUseCase: usecase.NewBlogUseCase(blogRepo,signupRepo, timeout),
		Env:         env,
	}
	
	router.Use(CORSMiddleware())

	router.POST("/blogs", blogController.CreateBlog)
	
	router.POST("/blogs/:blogID/comment", blogController.AddComment)
	router.POST("/blogs/:blogID/like", blogController.LikeBlog)
	
	router.POST("/blogs/:blogID/unlike", blogController.RemoveLikeBlog)

	router.GET("/blogs/page", blogController.GetRecentBlogs)
	router.GET("/blogs/popular/page", blogController.GetMostPopularBlogs)
	router.POST("/signup/email/username", blogController.Signup)


}
