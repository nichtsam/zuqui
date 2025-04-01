package user

import (
	"log"

	"github.com/gofiber/fiber/v2"

	"zuqui/internal/repo"
	"zuqui/internal/server/middleware"
)

func Profile(ur repo.UserRepo) func(c *fiber.Ctx) error {
	return func(c *fiber.Ctx) error {
		claims, ok := middleware.GetAuthClaims(c)
		if !ok {
			return c.SendStatus(fiber.StatusUnauthorized)
		}

		userId := claims.Subject
		user, err := ur.GetUserById(userId)
		if err != nil {
			log.Println(err)
			return fiber.NewError(fiber.StatusInternalServerError)
		}

		return c.JSON(user)
	}
}
