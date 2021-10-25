package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
)

func main() {

	fmt.Println("Hello Go")

	r := gin.Default()
	r.StaticFile("/favicon.ico", "./favicon.ico")

	//r.Use(favicon.New("./favicon.ico")) // set favicon middleware

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "Hello Docker Pong",
		})
	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
