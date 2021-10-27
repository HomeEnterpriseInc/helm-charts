{{/*
Expand the name of the chart.
*/}}
{{- define "tautulli.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tautulli.fullname" -}}
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
{{- define "tautulli.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tautulli.labels" -}}
helm.sh/chart: {{ include "tautulli.chart" . }}
{{ include "tautulli.selectorLabels" . }}
component: "media-monitoring-server"
{{- if .Values.hostNetwork }}
hostNetwork: {{ .Values.hostNetwork | quote }}
internal-service: {{not .Values.hostNetwork | quote }}
{{- end }}
managed-by: chynten
created-by: chynten
version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tautulli.selectorLabels" -}}
app-name: {{ include "tautulli.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "tautulli.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "tautulli.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
