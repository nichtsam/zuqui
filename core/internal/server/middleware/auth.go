package middleware

import (
	"log"
	"strings"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v5"

	"zuqui/internal/service/auth"
)

const CLAIMS_KEY = "auth_claims"

func AuthMiddleware(as auth.Service) func(c *fiber.Ctx) error {
	return func(c *fiber.Ctx) error {
		token, valid := getAccessToken(c.Get("Authorization"))
		if !valid {
			return c.SendStatus(fiber.StatusUnauthorized)
		}

		claims, err := as.VerifyAccessToken(token)
		if err != nil {
			if _, ok := err.(*auth.AuthError); ok {
				log.Println(err)
				return fiber.NewError(fiber.StatusUnauthorized)
			}
			log.Println(err)
			return fiber.NewError(fiber.StatusInternalServerError)
		}

		c.Locals(CLAIMS_KEY, claims)
		return c.Next()
	}
}

func getAccessToken(authorizationHeader string) (string, bool) {
	parts := strings.Split(authorizationHeader, "Bearer ")
	if len(parts) < 2 {
		return "", false
	}

	return parts[1], true
}

func GetAuthClaims(c *fiber.Ctx) (*jwt.RegisteredClaims, bool) {
	claims, ok := c.Locals(CLAIMS_KEY).(*jwt.RegisteredClaims)
	return claims, ok
}
