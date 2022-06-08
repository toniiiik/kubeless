/*
Copyright (c) 2016-2017 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package cronjob

import (
	"encoding/json"
	"fmt"
	"path/filepath"

	kubelessutil "github.com/kubeless/kubeless/pkg/utils"
	"github.com/spf13/cobra"
)

// CronjobTriggerCmd command for CronJob trigger commands
var CronjobTriggerCmd = &cobra.Command{
	Use:   "cronjob SUBCOMMAND",
	Short: "cronjob trigger specific operations",
	Long:  `cronjob trigger command allows user to create, list, update, delete cronjob triggers running on Kubeless`,
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Help()
	},
}

func init() {
	CronjobTriggerCmd.AddCommand(createCmd)
	CronjobTriggerCmd.AddCommand(deleteCmd)
	CronjobTriggerCmd.AddCommand(listCmd)
	CronjobTriggerCmd.AddCommand(updateCmd)
}

func parsePayload(content string, file string) (interface{}, error) {
	if len(file) > 0 {
		content, err := getPayloadRawContent(file)
		if err != nil {
			return nil, err
		}

		return parsePayloadContent(content), nil
	}

	return parsePayloadContent(content), nil
}

func getPayloadRawContent(file string) (string, error) {
	contentType, err := kubelessutil.GetContentType(file)
	if err != nil {
		return "", err
	}

	content, _, err := kubelessutil.ParseContent(file, contentType)
	if err != nil {
		return "", err
	}

	ext := filepath.Ext(file)
	if ext != ".json" {
		return "", fmt.Errorf("Sorry, we can't parse %s files yet", ext)
	}

	return content, nil
}

func parsePayloadContent(raw string) interface{} {
	var payload map[string]interface{}

	err := json.Unmarshal([]byte(raw), &payload)
	if err != nil {
		return fmt.Errorf("Found an error during JSON parsing on your payload: %s", err)
	}

	return payload
}
