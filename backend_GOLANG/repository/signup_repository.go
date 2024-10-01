package repository

import (
    "context"
    "tradmed/database"
    "tradmed/domain"

    "go.mongodb.org/mongo-driver/bson/primitive"
)

type UserRepository struct {
    database   database.Database
    collection string
}

func NewUserRepository(db database.Database, collectionName string) domain.UserRepositoryInterface {
    return &UserRepository{
        database:   db,
        collection: collectionName,
    }
}

func (r *UserRepository) InsertOne(ctx context.Context, user *domain.User_signup) error {
    collection := r.database.Collection(r.collection)

    user.UserID = primitive.NewObjectID()

    _, err := collection.InsertOne(ctx, user)
    return err
}
