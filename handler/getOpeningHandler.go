package handler

import (
	"net/http"

	"github.com/aleroxac/gopportunities/schemas"
	"github.com/gin-gonic/gin"
)

// @BasePath /api/v1

// @Summary Get opening
// @Description Get a job opening
// @Tags Openings
// @Accept json
// @Produce json
// @Param id query string true "Opening identification"
// @Success 200 {object} GetOpeningResponse
// @Failure 400 {object} ErrorResponse
// @Failure 404 {object} ErrorResponse
// @Router /opening [get]
func GetOpeningHandler(ctx *gin.Context) {
	id := ctx.Query("id")
	if id == "" {
		sendError(ctx, http.StatusBadRequest, errParamIsRequired("id", "queryParameter").Error())
		return
	}
	opening := schemas.Opening{}
	if err := db.First(&opening, id).Error; err != nil {
		sendError(ctx, http.StatusNotFound, "opening not found")
		return
	}
	sendSuccess(ctx, "get-opening", opening)
}
