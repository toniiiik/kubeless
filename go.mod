module github.com/kubeless/kubeless

go 1.13

require (
	github.com/ghodss/yaml v1.0.1-0.20190212211648-25d852aebe32
	github.com/golang/glog v1.0.0
	github.com/gosuri/uitable v0.0.0-20160404203958-36ee7e946282
	github.com/imdario/mergo v0.3.12
	github.com/mattn/go-runewidth v0.0.4 // indirect
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.57.0
	github.com/prometheus-operator/prometheus-operator/pkg/client v0.57.0
	github.com/prometheus/client_golang v1.11.0
	github.com/prometheus/common v0.28.0
	github.com/robfig/cron v0.0.0-20180505203441-b41be1df6967
	github.com/sirupsen/logrus v1.8.1
	github.com/spf13/cobra v1.2.1
	golang.org/x/net v0.0.0-20220127200216-cd36cc0744dd
	k8s.io/api v0.24.1
	k8s.io/apiextensions-apiserver v0.23.5
	k8s.io/apimachinery v0.24.1
	k8s.io/client-go v0.24.1
)
