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

func EducationRouter(env *config.Env, timeout time.Duration, db database.Database, router *gin.RouterGroup) {
	diseaseRepo := repository.NewDiseaseRepository(db, "disease")
	nuitrentRepo := repository.NewNutrientRepository(db, "nutrient")
	herbRepo := repository.NewHerbRepository(db, "herb")

	infoController := &controller.InfoController{
		EducationalUseCase: usecase.NewEducationalUseCase(diseaseRepo, herbRepo, nuitrentRepo, timeout),
		Env:                env,
	}
	router.Use(CORSMiddleware())

	router.GET("/disease/:diseaseName", infoController.GetDiseasesByname)
	router.POST("/disease", infoController.CreateDisease)
	router.GET("/disease/p/:page", infoController.GetAllDiseases)

	router.GET("/herb/:herbName", infoController.GetHerbsByName)
	router.POST("/herb", infoController.CreateHerb)
	router.GET("/herb", infoController.GetAllHerbs)

	router.GET("/nutrient/:nutrientName", infoController.GetNutrientsByName)
	router.POST("/nutrient", infoController.CreateNutrient)
	router.GET("/nutrient", infoController.GetAllNutrients)

}
