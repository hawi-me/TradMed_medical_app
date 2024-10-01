package controller

import (
	"net/http"
	"tradmed/config"
	"tradmed/domain"
	"strconv"

	"github.com/gin-gonic/gin"
)

type BlogController struct {
	BlogUseCase domain.BlogUseCaseInterface
	Env         *config.Env
}
func (uc *BlogController) Signup(c *gin.Context) {
    var user domain.User_signup
    user.Email = c.Param("email")
	user.Username = c.Param("username")


    err := uc.BlogUseCase.CreateUser(c, &user)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusOK, gin.H{"message": "User created successfully"})
}


func (bc *BlogController) CreateBlog(c *gin.Context) {
	var blog domain.Blog
	if err := c.ShouldBindJSON(&blog); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	id, err := bc.BlogUseCase.CreateBlog(c, &blog)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"blogID": id})
}



func (bc *BlogController) AddComment(c *gin.Context) {
	blogID := c.Param("blogID")
	var comment domain.Comment
	if err := c.ShouldBindJSON(&comment); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	err := bc.BlogUseCase.AddComment(c, blogID, &comment)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Comment added"})
}

func (bc *BlogController) LikeBlog(c *gin.Context) {
	blogID := c.Param("blogID")
	err := bc.BlogUseCase.LikeBlog(c, blogID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Blog liked"})
}

func (bc *BlogController) RemoveLikeBlog(c *gin.Context) {
	blogID := c.Param("blogID")
	err := bc.BlogUseCase.LikeBlog(c, blogID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Blog liked"})
}

func (bc *BlogController) GetRecentBlogs(c *gin.Context) {
	page := c.Param("page")
	intpage,_ := strconv.Atoi(page)
	blogs, err := bc.BlogUseCase.GetRecentBlogs(c, intpage, 5)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"blogs": blogs})
}

func (bc *BlogController) GetMostPopularBlogs(c *gin.Context) {
	page := c.Param("page")
	intpage,_ := strconv.Atoi(page)
	blogs, err := bc.BlogUseCase.GetMostPopularBlogs(c, intpage, 5)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"blogs": blogs})
}




