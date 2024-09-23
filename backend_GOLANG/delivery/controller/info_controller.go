package controller

import (
	"fmt"
	"strconv"
	"tradmed/config"
	"tradmed/domain"

	"github.com/gin-gonic/gin"
)

type InfoController struct {
	EducationalUseCase domain.EducationalUseCaseInterface
	Env                *config.Env
}

func (bc *InfoController) GetDiseasesByname(c *gin.Context)  {
	diseaseName := c.Param("diseaseName")
	disease, err := bc.EducationalUseCase.GetDiseaseByName(c,diseaseName)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, disease)
}

func (bc *InfoController) CreateDisease(c *gin.Context) {
	var disease domain.Disease
	if err := c.ShouldBindJSON(&disease); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	fmt.Println(disease)
	_, err := bc.EducationalUseCase.InsertOneDisease(c, &disease)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{
		"id": disease,
	})
}

func (bc *InfoController) GetAllDiseases(c *gin.Context) {
	page := c.Param("page")
	intpage,err := strconv.Atoi(page)

	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	

	
	diseases, err := bc.EducationalUseCase.GetAllDiseases(c,intpage)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, diseases)
}

func (bc *InfoController) GetHerbsByName(c *gin.Context) {
	herbName := c.Param("herbName")
	herb, err := bc.EducationalUseCase.GetHerbByName(c, herbName)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, herb)
}

func (bc *InfoController) CreateHerb(c *gin.Context) {
	var herb domain.Herb
	if err := c.ShouldBindJSON(&herb); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	id, err := bc.EducationalUseCase.InsertOneHerb(c, &herb)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{
		"id": id,
	})
}

func (bc *InfoController) GetAllHerbs(c *gin.Context) {
	herbs, err := bc.EducationalUseCase.GetAllHerbs(c)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, herbs)
}

func (bc *InfoController) GetNutrientsByName(c *gin.Context) {
	nutrientName := c.Param("nutrientName")
	nutrient, err := bc.EducationalUseCase.GetNutrientByName(c, nutrientName)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, nutrient)
}

func (bc *InfoController) CreateNutrient(c *gin.Context) {
	var nutrient domain.Nutrient
	if err := c.ShouldBindJSON(&nutrient); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	id, err := bc.EducationalUseCase.InsertOneNutrient(c, &nutrient)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{
		"id": id,
	})
}

func (bc *InfoController) GetAllNutrients(c *gin.Context) {
	nutrients, err := bc.EducationalUseCase.GetAllNutrients(c)
	if err != nil {
		c.JSON(500, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, nutrients)
}








