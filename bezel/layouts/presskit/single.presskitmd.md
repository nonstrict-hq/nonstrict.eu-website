{{- $kit := site.GetPage "/presskit" -}}
# {{ .Title }}

Press release · {{ .Date | time.Format ":date_long" }}

{{ .Params.lede }}

{{ .RawContent | replaceRE `(?s)\{\{<\s*carousel\s+caption="([^"]*)"\s*>\}\}\n(.*?)\n\{\{<\s*/carousel\s*>\}\}` "$2\n\n_${1}_" | strings.TrimSpace }}
{{ range .Params.links | default $kit.Params.links }}
{{ .title }}{{ with .note }} ({{ . }}){{ end }}: {{ .url }}
{{ end }}
