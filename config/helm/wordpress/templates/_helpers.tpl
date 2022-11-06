{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ilcittadinomb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ilcittadinomb.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ilcittadinomb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ilcittadinomb.labels" -}}
helm.sh/chart: {{ include "ilcittadinomb.chart" . }}
{{ include "ilcittadinomb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ilcittadinomb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ilcittadinomb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ilcittadinomb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ilcittadinomb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "phpfpm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "phpfpm.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "phpfpm.labels" }}
labels:
  name: {{ include "phpfpm.fullname" . }}
  helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
  {{- include "phpfpm.selectorLabels" . | indent 2 }}
  app.kubernetes.io/managed-by: {{ .Release.Service }}
  {{- if .Chart.AppVersion }}
  app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
  {{- if .Values.labels }}
  {{- range $key, $value := .Values.labels }}
  {{ $key }}: {{ $value | quote }}
  {{- end }}
  {{- end}}
  {{- if .Values.global.ci.labels }}
  {{- range $key, $value := .Values.global.ci.values }}
  {{ $key }}: {{ $value | quote }}
  {{- end}}
  {{- end}}
{{- end }}

{{- define "phpfpm.selectorLabels" }}
app.kubernetes.io/name: {{ include "phpfpm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "phpfpm.cleanEnvs" }}
  {{- $envs := list }}
  {{- range . }}
    {{- $envs = append $envs (omit . "excludeFromHooks") }}
  {{- end }}
  {{- if gt (len  $envs) 0 }}
{{- toYaml $envs }}
  {{- end }}
{{- end }}

