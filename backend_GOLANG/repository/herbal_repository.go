package repository

import (
	"context"
	"tradmed/database"
	"tradmed/domain"
	"go.mongodb.org/mongo-driver/bson"

)

type HerbRepository struct {
	database   database.Database
	collection string
}

func NewHerbRepository(db database.Database, collectionName string) domain.HerbRepositoryInterface {
	return &HerbRepository{
		database:   db,
		collection: collectionName,
	}
}


func (r *HerbRepository) GetHerbByName(ctx context.Context, name string) (*domain.Herb, error) {
	var herb domain.Herb
	collection := r.database.Collection(r.collection)
	err := collection.FindOne(ctx, bson.M{"name": name}).Decode(&herb)
	if err != nil {
		return nil, err
	}

	return &herb, nil
}

func (r *HerbRepository) InsertOne(ctx context.Context, herb *domain.Herb) (string, error) {
	collection := r.database.Collection(r.collection)
	res, err := collection.InsertOne(ctx, herb)
	if err != nil {
		return "", err
	}
	return res.(string), nil
}

func (r *HerbRepository) GetAllHerbs(ctx context.Context) ([]domain.Herb, error) {
	var herbs []domain.Herb
	collection := r.database.Collection(r.collection)
	cursor, err := collection.Find(ctx, bson.M{})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var herb domain.Herb
		err := cursor.Decode(&herb)
		if err != nil {
			return nil, err
		}
		herbs = append(herbs, herb)
	}
	return herbs, nil
}
