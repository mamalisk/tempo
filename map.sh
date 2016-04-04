# Set a value:
declare "jars_$key=$value"

# Get a value:
arrayGet() { 
    local array=$1 key=$2
    local i="${array}_$key"
    printf '%s' "${!i}"
}