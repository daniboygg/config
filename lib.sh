CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

step() {
    local color="$1"
    local message="$2"
    echo -e "${color}==> ${message}${RESET}"
}
