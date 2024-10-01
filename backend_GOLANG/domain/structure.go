package domain

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Disease struct {
	ID          primitive.ObjectID `bson:"_id,omitempty"`
	Name        string             `bson:"name"`
	Description string             `bson:"description"`
	Symptoms    []string           `bson:"symptoms"`
	Treatment   string             `bson:"treatment"`
	Prevention  string             `bson:"prevention"`
	Images      string             `bson:"images"`
}

type Nutrient struct {
	ID          primitive.ObjectID `bson:"_id,omitempty"`
	Name        string             `bson:"name"`
	Description string             `bson:"description"`
	Deficiency  string             `bson:"deficiency"`
	Source      string             `bson:"source"`
}

type Herb struct {
	ID          primitive.ObjectID `bson:"_id,omitempty"`
	Name        string             `bson:"name"`
	Usage       string             `bson:"usage"`
	Price       string             `bson:"price"`
	Currency    string             `bson:"currency"`
	SideEffects []string           `bson:"side_effects"`
	Images      string             `bson:"images"`
	NearbyShops []Shop             `bson:"nearby_shops"`
}

type Shop struct {
	ShopName string `bson:"shop_name"`
	Address  string `bson:"address"`
	Contact  string `bson:"contact"`
}

type Blog struct {
	ID        string    `bson:"_id,omitempty"`
	Title     string    `json:"title" binding:"required"`
	Author    string    `json:"author" binding:"required"`
	Content   string    `json:"content" binding:"required"`
	CreatedAt time.Time `json:"createdAt"`
	Comments  []Comment `json:"comments"`
	Likes     int       `json:"likes"`
}

type Comment struct {
	CommentID primitive.ObjectID `bson:"_id,omitempty"`
	Author    string             `json:"author" binding:"required"`
	Content   string             `json:"content" binding:"required"`
	Date      time.Time          `json:"date"`
}


type User_signup struct {
    UserID   primitive.ObjectID `bson:"_id,omitempty"`
    Username string             `json:"username" binding:"required"`
    Email    string             `json:"email" binding:"required,email"`
}

