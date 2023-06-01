package router

import "github.com/gin-gonic/gin"

func Initialize() {
	router := gin.Default()
	gin.SetMode(gin.ReleaseMode)
	router.SetTrustedProxies(nil)

	initializeRoutes(router)

	router.Run(":8000")
}
