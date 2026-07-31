#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Main CLI Orchestrator Engine
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/tui.sh"
source "${SCRIPT_DIR}/lib/lock_manager.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"
source "${SCRIPT_DIR}/lib/manifest_validator.sh"
source "${SCRIPT_DIR}/bootstrap/cli_parser.sh"

show_help() {
    tui_banner
    cat <<EOF
Usage: bootstrap [COMMAND] [OPTIONS]

Commands:
  run          Execute complete framework provisioning pipeline (default)
  doctor       Execute diagnostic health check suite
  repair       Execute self-healing repair routines
  rollback     Restore system state from latest backup snapshot
  update       Check and update bootstrap framework code
  report       Generate structured markdown telemetry reports
  benchmark    Run system CPU and disk I/O performance benchmark
  help         Display this help message

Options:
  --dry-run    Simulate execution without modifying system state
  -v, --verbose Enable verbose debug logging output
  -h, --help    Show help message

Examples:
  ./bootstrap.sh run
  ./doctor.sh
  ./repair.sh
  ./rollback.sh
EOF
}

run_pipeline() {
    log_section "Termux Bootstrap Framework Pipeline"
    tui_banner

    log_info "Step 1/9: Initializing Lock Guard & State Database..."
    acquire_lock
    trap release_lock EXIT

    state_db_init

    log_info "Step 2/9: Validating Framework Manifest Schemas..."
    validate_all_manifests

    log_info "Step 3/9: Creating Pre-flight Rollback Snapshot..."
    source "${SCRIPT_DIR}/modules/backup_manager.sh"
    create_backup_snapshot "pre_bootstrap"

    log_info "Step 4/9: Running System Environment Detection..."
    source "${SCRIPT_DIR}/modules/android_detection.sh"
    run_android_detection
    source "${SCRIPT_DIR}/modules/arch_detection.sh"
    run_arch_detection

    log_info "Step 5/9: Synchronizing APT Repositories & Packages..."
    source "${SCRIPT_DIR}/modules/repository_manager.sh"
    run_repository_manager
    source "${SCRIPT_DIR}/modules/package_manager.sh"
    run_package_manager

    log_info "Step 6/9: Running Custom Installer Pipeline..."
    source "${SCRIPT_DIR}/modules/installer_manager.sh"
    run_installer_manager

    log_info "Step 7/9: Configuring System Managers (Git, SSH, Shell, Storage)..."
    source "${SCRIPT_DIR}/modules/git_manager.sh"
    run_git_manager
    source "${SCRIPT_DIR}/modules/ssh_manager.sh"
    run_ssh_manager
    source "${SCRIPT_DIR}/modules/storage_manager.sh"
    run_storage_manager
    source "${SCRIPT_DIR}/modules/shell_manager.sh"
    run_shell_manager

    log_info "Step 8/9: Initializing Environment Workspaces (AI, Dev, Containers)..."
    source "${SCRIPT_DIR}/modules/ai_env.sh"
    run_ai_env
    source "${SCRIPT_DIR}/modules/dev_env.sh"
    run_dev_env
    source "${SCRIPT_DIR}/modules/containers_module.sh"
    run_containers_module
    source "${SCRIPT_DIR}/modules/graphics_module.sh"
    run_graphics_module

    log_info "Step 9/9: Generating Diagnostic Telemetry Reports..."
    source "${SCRIPT_DIR}/modules/reporting_module.sh"
    generate_all_reports

    log_success "================================================================="
    log_success "Termux Bootstrap Framework Provisioning Completed Successfully!"
    log_success "================================================================="
}

main() {
    parse_cli_args "$@"

    case "${COMMAND}" in
        run)
            run_pipeline
            ;;
        doctor)
            source "${SCRIPT_DIR}/modules/doctor_module.sh"
            run_doctor_module
            ;;
        repair)
            source "${SCRIPT_DIR}/modules/repair_module.sh"
            run_repair_module
            ;;
        rollback)
            source "${SCRIPT_DIR}/modules/rollback_manager.sh"
            restore_latest_snapshot
            ;;
        update)
            source "${SCRIPT_DIR}/modules/update_module.sh"
            run_update_module
            ;;
        report)
            source "${SCRIPT_DIR}/modules/reporting_module.sh"
            generate_all_reports
            ;;
        benchmark)
            source "${SCRIPT_DIR}/modules/benchmark_module.sh"
            run_benchmark
            ;;
        help)
            show_help
            ;;
        *)
            log_error "Unknown command: ${COMMAND}"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
