module github.com/kubeless/kubeless

go 1.13

require (
	cloud.google.com/go/compute v1.3.0 // indirect
	github.com/Azure/go-autorest/autorest v0.11.24 // indirect
	github.com/ghodss/yaml v1.0.1-0.20190212211648-25d852aebe32
	github.com/go-logr/logr v1.2.2 // indirect
	github.com/go-openapi/jsonreference v0.19.6 // indirect
	github.com/go-openapi/swag v0.21.1 // indirect
	github.com/golang/glog v1.0.0
	github.com/google/go-cmp v0.5.8 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/google/uuid v1.2.0 // indirect
	github.com/imdario/mergo v0.3.12
	// github.com/kubeless/cronjob-trigger v0.0.0-00010101000000-000000000000
	// github.com/kubeless/http-trigger v1.0.3
	// github.com/kubeless/kafka-trigger v1.1.0
	github.com/mailru/easyjson v0.7.7 // indirect
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.57.0
	github.com/prometheus-operator/prometheus-operator/pkg/client v0.57.0
	github.com/prometheus/client_golang v1.12.2
	github.com/prometheus/common v0.34.0
	github.com/sirupsen/logrus v1.8.1
	github.com/spf13/cobra v1.4.0
	github.com/stretchr/testify v1.7.1 // indirect
	golang.org/x/net v0.0.0-20220225172249-27dd8689420f
	golang.org/x/sys v0.0.0-20220222172238-00053529121e // indirect
	google.golang.org/protobuf v1.28.0 // indirect
	gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c // indirect
	k8s.io/api v0.24.1
	k8s.io/apiextensions-apiserver v0.24.1
	k8s.io/apimachinery v0.24.1
	k8s.io/client-go v0.24.1
)

// replace github.com/kubeless/http-trigger => ../http-trigger

// replace github.com/kubeless/cronjob-trigger => ../cronjob-trigger

// replace github.com/kubeless/kafka-trigger => ../kafka-trigger
