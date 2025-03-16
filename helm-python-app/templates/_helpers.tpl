{{/*
Expand the name of the chart.
*/}}
{{- define "python-web-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "python-web-app.fullname" -}}
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
{{- define "python-web-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "python-web-app.labels" -}}
helm.sh/chart: {{ include "python-web-app.chart" . }}
{{ include "python-web-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "python-web-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "python-web-app.name" . }}
app.kubernetes.io/fullname: {{ include "python-web-app.fullname" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "python-web-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "python-web-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Use env and secret in a one function
*/}}
{{- define "python-web-app.listEnvVariables"}}
{{- range $key, $val := .Values.env.secret }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ include "python-web-app.fullname" $ }}
      key: {{ $key }}
{{- end}}
{{- range $key, $val := .Values.env.public }}
- name: {{ $key }}
  value: {{ $val | quote }}
{{- end}}
{{- end }}
