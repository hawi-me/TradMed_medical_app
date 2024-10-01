package usecase

import (
	"context"
	"time"
	"tradmed/domain"
)

type blogUseCase struct {
	blogRepo       domain.BlogRepositoryInterface
	userRepo       domain.UserRepositoryInterface
	contextTimeout time.Duration
}

func NewBlogUseCase(br domain.BlogRepositoryInterface, ur domain.UserRepositoryInterface, timeout time.Duration) domain.BlogUseCaseInterface {
	return &blogUseCase{
		blogRepo:       br,
		userRepo:       ur,
		contextTimeout: timeout,
	}
}
func (u *blogUseCase) CreateUser(ctx context.Context, user *domain.User_signup) error {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.userRepo.InsertOne(ctx, user)
}

func (u *blogUseCase) CreateBlog(ctx context.Context, blog *domain.Blog) (string, error) {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.blogRepo.InsertOne(ctx, blog)
}

func (u *blogUseCase) AddComment(ctx context.Context, blogID string, comment *domain.Comment) error {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.blogRepo.AddComment(ctx, blogID, comment)
}

func (u *blogUseCase) LikeBlog(ctx context.Context, blogID string) error {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.blogRepo.LikeBlog(ctx, blogID)
}
func (u *blogUseCase) RemoveLikeBlog(ctx context.Context, blogID string) error {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.blogRepo.LikeBlog(ctx, blogID)
}

func (u *blogUseCase) GetRecentBlogs(ctx context.Context, page, limit int) ([]domain.Blog, error) {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.blogRepo.GetRecentBlogs(ctx, page, limit)
}
func (u *blogUseCase) GetMostPopularBlogs(ctx context.Context, page, limit int) ([]domain.Blog, error) {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.blogRepo.GetMostPopularBlogs(ctx, page, limit)
}
