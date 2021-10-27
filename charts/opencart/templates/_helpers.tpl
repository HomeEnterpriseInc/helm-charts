{{/*
Expand the name of the chart.
*/}}
{{- define "opencart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "opencart.fullname" -}}
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
{{- define "opencart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "opencart.labels" -}}
helm.sh/chart: {{ include "opencart.chart" . }}
{{ include "opencart.selectorLabels" . }}
component: "ecommerce-server"
hostNetwork: {{ .Values.hostNetwork | quote }}
internal-service: {{not .Values.hostNetwork | quote }}
managed-by: chynten
created-by: chynten
version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "opencart.selectorLabels" -}}
app-name: {{ include "opencart.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "opencart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "opencart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
