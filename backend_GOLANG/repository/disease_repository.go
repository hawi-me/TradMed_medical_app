package repository

import (
	"context"
	"tradmed/database"
	"tradmed/domain"

	"fmt"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type DiseaseRepository struct {
	database   database.Database
	collection string
}

func NewDiseaseRepository(db database.Database, collectionName string) domain.DiseaseRepositoryInterface {
	return &DiseaseRepository{
		database:   db,
		collection: collectionName,
	}
}

func (r *DiseaseRepository) GetDiseaseByName(ctx context.Context, name string) (*domain.Disease, error) {
	var disease domain.Disease
	collection := r.database.Collection(r.collection)
	fmt.Println(name)
	filter := bson.M{}
	filter["name"] = bson.M{"$regex": name, "$options": "i"}

	err := collection.FindOne(ctx, filter).Decode(&disease)
	if err != nil {
		return nil, err
	}
	fmt.Println(disease)
	return &disease, nil

}

func (r *DiseaseRepository) InsertOne(ctx context.Context, disease *domain.Disease) (string, error) {
	collection := r.database.Collection(r.collection)
	println(disease)
	res, err := collection.InsertOne(ctx, disease)
	println(res)
	if err != nil {
		return "", err
	}
	return "", nil
}

func (r *DiseaseRepository) GetAllDiseases(ctx context.Context, page int) ([]domain.Disease, error) {
	limit := 5
	if page < 1 {
		page = 1
	}

	skip := (page - 1) * limit
	fmt.Println("Skip:", skip, "Limit:", limit)

	// Configure find options with sorting, skipping, and limiting
	findOptions := options.Find().
		SetSkip(int64(skip)).
		SetLimit(int64(limit))

	collection := r.database.Collection(r.collection)

	// Execute the query
	cursor, err := collection.Find(ctx, bson.M{}, findOptions)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)

	var diseases []domain.Disease
	for cursor.Next(ctx) {
		var disease domain.Disease
		err := cursor.Decode(&disease)
		if err != nil {
			fmt.Println("Error decoding document:", err)
			continue // Skip this document and continue processing others
		}
		diseases = append(diseases, disease)
	}

	// Check if there were any errors during cursor iteration

	if len(diseases) == 0 {
		fmt.Println("No diseases found.")
	}

	return diseases, nil
}
