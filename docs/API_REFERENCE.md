# Library API Reference

## `lib/logger.sh`
- `log_info "msg"`: Standard informational logging.
- `log_success "msg"`: Success logging.
- `log_warn "msg"`: Warning logging.
- `log_error "msg"`: Error output to stderr.
- `log_section "title"`: Formatted section banner.

## `lib/state_db.sh`
- `state_db_init`: Initialize JSON database.
- `state_db_get_key "key"`: Read key value.
- `state_db_set_key "key" "val"`: Write key value.
- `state_db_add_item "list" "item"`: Append item to array list.

## `lib/download_engine.sh`
- `download_file "primary_url" "output_path" "hash" "retries" "fallbacks..."`: Resilient multi-mirror downloader.
EOF
