package usecase

import (
	"context"
	"time"
	"tradmed/domain"
)

type educationalUseCase struct {
	diseasesRepo   domain.DiseaseRepositoryInterface
	herbsRepo      domain.HerbRepositoryInterface
	nutrientsRepo  domain.NutrientRepositoryInterface
	contextTimeout time.Duration
}

func NewEducationalUseCase(d domain.DiseaseRepositoryInterface, h domain.HerbRepositoryInterface, n domain.NutrientRepositoryInterface, timeout time.Duration) domain.EducationalUseCaseInterface {
	return &educationalUseCase{
		diseasesRepo:   d,
		herbsRepo:      h,
		nutrientsRepo:  n,
		contextTimeout: timeout,
	}
}

func (u *educationalUseCase) InsertOneDisease(ctx context.Context, disease *domain.Disease) (string, error) {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.diseasesRepo.InsertOne(ctx, disease)
}

func (u *educationalUseCase) GetDiseaseByName(ctx context.Context, name string) (*domain.Disease, error) {
	_, cancel := context.WithTimeout(context.Background(), u.contextTimeout)
	defer cancel()

	return u.diseasesRepo.GetDiseaseByName(ctx, name)

}

func (u *educationalUseCase) GetAllDiseases(ctx context.Context,page int) ([]domain.Disease, error) {
	_, cancel := context.WithTimeout(context.Background(), u.contextTimeout)
	defer cancel()

	return u.diseasesRepo.GetAllDiseases(ctx,page)
}

func (u *educationalUseCase) InsertOneHerb(ctx context.Context, herb *domain.Herb) (string, error) {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.herbsRepo.InsertOne(ctx, herb)
}

func (u *educationalUseCase) GetHerbByName(ctx context.Context, name string) (*domain.Herb, error) {
	_, cancel := context.WithTimeout(context.Background(), u.contextTimeout)
	defer cancel()

	return u.herbsRepo.GetHerbByName(ctx, name)
}

func (u *educationalUseCase) GetAllHerbs(ctx context.Context) ([]domain.Herb, error) {
	_, cancel := context.WithTimeout(context.Background(), u.contextTimeout)
	defer cancel()

	return u.herbsRepo.GetAllHerbs(ctx)
}

func (u *educationalUseCase) InsertOneNutrient(ctx context.Context, nutrient *domain.Nutrient) (string, error) {
	_, cancel := context.WithTimeout(ctx, u.contextTimeout)
	defer cancel()

	return u.nutrientsRepo.InsertOne(ctx, nutrient)
}

func (u *educationalUseCase) GetNutrientByName(ctx context.Context, name string) (*domain.Nutrient, error) {
	_, cancel := context.WithTimeout(context.Background(), u.contextTimeout)
	defer cancel()

	return u.nutrientsRepo.GetNutrientByName(ctx, name)
}

func (u *educationalUseCase) GetAllNutrients(ctx context.Context) ([]domain.Nutrient, error) {
	_, cancel := context.WithTimeout(context.Background(), u.contextTimeout)
	defer cancel()

	return u.nutrientsRepo.GetAllNutrients(ctx)
}
