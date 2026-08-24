run "deploy" {
  command = apply
}

run "validate_root" {
  command = apply

  module {
    source  = "brikis98/devops/book//modules/test-endpoint"
    version = "1.0.1"
  }

  variables {
    endpoint = run.deploy.function_url
  }

  assert {
    condition     = data.http.test_endpoint.status_code == 200
    error_message = "Unexpected status: ${data.http.test_endpoint.status_code}"
  }

  assert {
    condition     = data.http.test_endpoint.response_body == "Hello, World!"
    error_message = "Unexpected body: ${data.http.test_endpoint.response_body}"
  }
}

run "validate_name" {
  command = apply

  module {
    source  = "brikis98/devops/book//modules/test-endpoint"
    version = "1.0.1"
  }

  variables {
    endpoint = "${run.deploy.function_url}name/spam"
  }

  assert {
    condition     = data.http.test_endpoint.status_code == 200
    error_message = "Unexpected status: ${data.http.test_endpoint.status_code}"
  }

  assert {
    condition     = data.http.test_endpoint.response_body == "Hello, Spam!"
    error_message = "Unexpected body: ${data.http.test_endpoint.response_body}"
  }
}
