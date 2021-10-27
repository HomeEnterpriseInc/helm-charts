{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "wg-access-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wg-access-server.fullname" -}}
{{ include "wg-access-server.name" . }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "wg-access-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}

{{- define "wg-access-server.labels" -}}
helm.sh/chart: {{ include "wg-access-server.chart" . }}
{{ include "wg-access-server.selectorLabels" . }}
component: "vpn-server"
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
{{- define "wg-access-server.selectorLabels" -}}
app-name: {{ include "wg-access-server.name" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "wg-access-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "wg-access-server.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
