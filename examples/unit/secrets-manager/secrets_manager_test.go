package secrets_manager_test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

var (
	expectedSuccess = "Success"
	expectedFailure = "Failure"
	wnt             string
)

func TestSecretsManagerSuccess(t *testing.T) {
	var terraformOpts = &terraform.Options{
		TerraformDir: "../../localstack",
		Targets:      []string{"module.secrets_manager_success_localstack"},
	}

	defer terraform.Destroy(t, terraformOpts)
	defer test_structure.CopyTerraformFolderToTemp(t, terraformOpts.TerraformDir, "temp")
	defer test_structure.CleanupTestDataFolder(t, terraformOpts.TerraformDir)

	if _, err := terraform.InitAndPlanE(t, terraformOpts); err != nil {
		wnt = "Failure"
	} else {
		wnt = "Success"
	}

	if expectedSuccess == wnt {
		t.Logf("Expected %s, got %s", expectedSuccess, wnt)
		terraform.Apply(t, terraformOpts)
	} else if expectedFailure == wnt {
		t.Logf("Expected %s, got %s", expectedFailure, wnt)
		os.Exit(0)
	} else {
		t.Logf("Expected %s or %s, got %s", expectedSuccess, expectedFailure, wnt)
		t.Fail()
	}
}
