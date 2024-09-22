package repository

import (
	"context"
	"tradmed/database"
	"tradmed/domain"
	"go.mongodb.org/mongo-driver/bson"
)

type NutrientRepository struct {
	database   database.Database
	collection string
}

func NewNutrientRepository(db database.Database, collectionName string) domain.NutrientRepositoryInterface {
	return &NutrientRepository{
		database:   db,
		collection: collectionName,
	}
}



func (r *NutrientRepository) GetNutrientByName(ctx context.Context, name string) (*domain.Nutrient, error) {
	var nutrient domain.Nutrient
	collection := r.database.Collection(r.collection)
	err := collection.FindOne(ctx, bson.M{"name": name}).Decode(&nutrient)
	if err != nil {
		return nil, err
	}

	return &nutrient, nil
}

func (r *NutrientRepository) InsertOne(ctx context.Context, nutrient *domain.Nutrient) (string, error) {
	collection := r.database.Collection(r.collection)
	res, err := collection.InsertOne(ctx, nutrient)
	if err != nil {
		return "", err
	}
	return res.(string), nil
}

func (r *NutrientRepository) GetAllNutrients(ctx context.Context) ([]domain.Nutrient, error) {
	var nutrients []domain.Nutrient
	collection := r.database.Collection(r.collection)
	cursor, err := collection.Find(ctx, bson.M{})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var nutrient domain.Nutrient
		err := cursor.Decode(&nutrient)
		if err != nil {
			return nil, err
		}
		nutrients = append(nutrients, nutrient)
	}
	return nutrients, nil
}
