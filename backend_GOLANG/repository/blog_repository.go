package repository

import (
	"context"
	"tradmed/database"
	"tradmed/domain"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type BlogRepository struct {
	database   database.Database
    userRepo database.Database
	collection string
}

func NewBlogRepository(db database.Database, collectionName string) domain.BlogRepositoryInterface {
	return &BlogRepository{
		database:   db,
		collection: collectionName,
	}
}

func (r *BlogRepository) InsertOne(ctx context.Context, blog *domain.Blog) (string, error) {
	collection := r.database.Collection(r.collection)
	_, err := collection.InsertOne(ctx, blog)
	if err != nil {
		return "", err
	}
	return "", nil
}


func (r *BlogRepository) AddComment(ctx context.Context, blogID string, comment *domain.Comment) error {
	collection := r.database.Collection(r.collection)

	comment.CommentID = primitive.NewObjectID()

	blogIDPrimitive, _ := primitive.ObjectIDFromHex(blogID)
	filter := bson.M{"_id": blogIDPrimitive}
	update := bson.M{"$push": bson.M{"comments": comment}}
	_, err := collection.UpdateOne(ctx, filter, update)
	
	return err
}

func (r *BlogRepository) LikeBlog(ctx context.Context, blogID string) error {
	collection := r.database.Collection(r.collection)
	blogIDPrimitive, _ := primitive.ObjectIDFromHex(blogID)
	filter := bson.M{"_id": blogIDPrimitive}
	update := bson.M{"$inc": bson.M{"likes": 1}}
	_, err := collection.UpdateOne(ctx, filter, update)
	return err
}
func (r *BlogRepository) RemoveLikeBlog(ctx context.Context, blogID string) error {
	collection := r.database.Collection(r.collection)
	blogIDPrimitive, _ := primitive.ObjectIDFromHex(blogID)
	filter := bson.M{"_id": blogIDPrimitive}
	update := bson.M{"$inc": bson.M{"likes": -1}}
	_, err := collection.UpdateOne(ctx, filter, update)
	return err
}
func (r *BlogRepository) GetRecentBlogs(ctx context.Context, page, limit int) ([]domain.Blog, error) {
    if page < 1 {
        page = 1
    }
    if limit < 1 {
        limit = 10 // Default limit if not specified
    }

    skip := (page - 1) * limit

    // Configure find options with sorting, skipping, and limiting
    opts := options.Find().
        SetSort(bson.D{{"createdAt", -1}}).
        SetSkip(int64(skip)).
        SetLimit(int64(limit))

    collection := r.database.Collection(r.collection)

    // Execute the query
    cursor, err := collection.Find(ctx, bson.M{}, opts)
    if err != nil {
        return nil, err
    }
    defer cursor.Close(ctx)

    var blogs []domain.Blog
    if err = cursor.All(ctx, &blogs); err != nil {
        return nil, err
    }

    return blogs, nil
}


func (r *BlogRepository) GetMostPopularBlogs(ctx context.Context, page, limit int) ([]domain.Blog, error) {
    if page < 1 {
        page = 1
    }
    if limit < 1 {
        limit = 10 // Default limit if not specified
    }

    skip := (page - 1) * limit

    // Configure find options with sorting, skipping, and limiting
    opts := options.Find().
        SetSort(bson.D{{"likes", -1}}).
        SetSkip(int64(skip)).
        SetLimit(int64(limit))

    collection := r.database.Collection(r.collection)

    // Execute the query
    cursor, err := collection.Find(ctx, bson.M{}, opts)
    if err != nil {
        return nil, err
    }
    defer cursor.Close(ctx)

    var blogs []domain.Blog
    if err = cursor.All(ctx, &blogs); err != nil {
        return nil, err
    }

    return blogs, nil
}
