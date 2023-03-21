package secrets_manager_test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestSecretsManager(t *testing.T) {
	var terraformOpts = &terraform.Options{
		TerraformDir: "../../localstack",
		Targets:      []string{"module.secrets_manager_localstack"},
	}

	defer terraform.Destroy(t, terraformOpts)
	terraform.InitAndApply(t, terraformOpts)
}
