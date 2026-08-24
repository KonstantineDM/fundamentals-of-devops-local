package test

import (
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestLambdaFunction(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    "../",
		TerraformBinary: "tofu",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	functionURL := terraform.Output(t, terraformOptions, "function_url")

	assert.NotEmpty(t, functionURL)

	http_helper.HttpGetWithRetry(
		t,
		functionURL,
		nil,
		200,
		"Hello, Terraform!",
		30,
		5*time.Second,
	)
}