Bezel press kit
{{ range .Params.links }}
{{ .title }}{{ with .note }} ({{ . }}){{ end }}: {{ .url }}
{{- end }}
Contact: {{ .Params.contact }}

Content:

- press-release/
  The press release: its text (press-release.md) and the images and video from the website.
{{ range (site.GetPage "/presskit/assets").Params.folders }}
- {{ .dir }}/
  {{ .text }}
{{ end -}}
