package route

import (
	"tradmed/config"
	"tradmed/database"
	// "tradmed/delivery/middleware"
	"time"

	"github.com/gin-gonic/gin"
	// "github.com/google/generative-ai-go/genai"
)

func CORSMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Origin, Content-Type, X-Auth-Token")
		c.Next()
	}
}
func Setup(env *config.Env, timeout time.Duration, db database.Database, gin *gin.Engine) {

	
	
	publicRouter := gin.Group("/api")
	EducationRouter(env, timeout, db, publicRouter)
	BlogRouter(env, timeout, db, publicRouter)
	// UserRouter(env, timeout, db, publicRouter)

	

}
