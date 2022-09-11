#!/bin/sh
set -e

ME=$(basename $0)

auto_envsubst() {
  template_dir="/etc/nginx/$1"
  suffix=".conf"
  output_dir="/etc/nginx/$2"

  local template defined_envs relative_path output_path subdir
  defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
  [ -d "$template_dir" ] || return 0
  if [ ! -w "$output_dir" ]; then
    echo >&3 "$ME: ERROR: $template_dir exists, but $output_dir is not writable"
    return 0
  fi
  find "$template_dir" -follow -type f -name "*$suffix" -print | while read -r template; do
    relative_path="${template#$template_dir/}"
    output_path="$output_dir/${relative_path}"
    # output_path="$output_dir/${relative_path%$suffix}"
    subdir=$(dirname "$relative_path")
    # create a subdirectory where the template file exists
    mkdir -p "$output_dir/$subdir"
    echo "$ME: Running envsubst on $template to $output_path"
    envsubst "$defined_envs" < "$template" > "$output_path"
  done
}


if [ "$encrypt" = true ] ; then
    echo "Configuration Nginx..."
    auto_envsubst http.templates.d conf.d
    auto_envsubst stream.templates.d stream.d
    # Launch nginx
    echo "Starting nginx..."
    exec nginx -g 'daemon off;'
else
exec "$@"
fi
