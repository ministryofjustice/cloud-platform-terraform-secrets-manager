package main

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

var (
	wntErr bool
)

func TestSMValidateSuccess(t *testing.T) {
	t.Parallel()
	t.Log("Testing ECR module")
	wntErr = false

	terraformOptions := &terraform.Options{
		TerraformDir: "unit-test/success",
	}

	_, err := terraform.InitE(t, terraformOptions)
	if err != nil {
		t.Fatal(err)
	}

	v, err := terraform.ValidateE(t, terraformOptions)
	if err != nil && !wntErr {
		t.Fatalf("Wanted Error: %v\nExpected nil got %v", wntErr, err)

	} else {
		t.Logf("Wanted Error: %v\nExpected nil got %v", wntErr, err)
		t.Log(v)
	}

}

func TestSMValidateFailure(t *testing.T) {
	t.Parallel()
	t.Log("Testing ECR module")
	wntErr = true

	terraformOptions := &terraform.Options{
		TerraformDir: "unit-test/failure",
	}

	_, err := terraform.InitE(t, terraformOptions)
	if err != nil {
		t.Fatal(err)
	}

	v, err := terraform.ValidateE(t, terraformOptions)
	if err != nil && wntErr {
		t.Logf("Wanted Error: %v\nExpected error got %v", wntErr, err)
		t.Log(v)
	} else {
		t.Fatalf("Wanted Error: %v\nExpected error got %v", wntErr, err)
	}
}
