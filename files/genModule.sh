mkdir -p target

name="$1"
modules="$2"
content="$(cat <<-EOF
package $name

modules = $modules
sourcedir = src
executable = $name
main = Main
opts = "--ibcsubdir target/ibcs"
EOF
)"

echo "$content" > "target/$name.ipkg"
echo "$name" > "target/moduleName"

