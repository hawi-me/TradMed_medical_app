package domain

import (
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
	Description string             `bson:"description"`
	Usage       string             `bson:"usage"`
	Preparation string             `bson:"preparation"`
}
