{{/*
Expand the name of the chart.
*/}}
{{- define "alfred.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "alfred.fullname" -}}
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
{{- define "alfred.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alfred.labels" -}}
helm.sh/chart: {{ include "alfred.chart" . }}
{{ include "alfred.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alfred.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alfred.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Component labels - extends selector labels with a component name
*/}}
{{- define "alfred.componentLabels" -}}
{{ include "alfred.selectorLabels" . }}
app.kubernetes.io/component: {{ .component }}
{{- end }}

{{/*
PostgreSQL host helper
*/}}
{{- define "alfred.postgresql.host" -}}
{{- printf "%s-postgresql" (include "alfred.fullname" .) }}
{{- end }}

{{/*
PostgreSQL URL helper
*/}}
{{- define "alfred.postgresql.url" -}}
{{- printf "postgresql://%s:$(POSTGRES_PASSWORD)@%s:%d/%s" .Values.postgresql.auth.username (include "alfred.postgresql.host" .) (int .Values.postgresql.service.port) .Values.postgresql.auth.database }}
{{- end }}

{{/*
Redis host helper
*/}}
{{- define "alfred.redis.host" -}}
{{- printf "%s-redis" (include "alfred.fullname" .) }}
{{- end }}

{{/*
RabbitMQ host helper
*/}}
{{- define "alfred.rabbitmq.host" -}}
{{- printf "%s-rabbitmq" (include "alfred.fullname" .) }}
{{- end }}

{{/*
Dendrite host helper
*/}}
{{- define "alfred.dendrite.host" -}}
{{- printf "%s-dendrite" (include "alfred.fullname" .) }}
{{- end }}
