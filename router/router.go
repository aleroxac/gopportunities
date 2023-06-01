package router

import "github.com/gin-gonic/gin"

func Initialize() {
	r := gin.Default()
	gin.SetMode(gin.ReleaseMode)
	r.SetTrustedProxies(nil)

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.Run(":8000")
}
