#!/bin/sh

old_size="128"
new_size="101"

main () {
  if [ -e "$new_size" ]; then
    rm -rf "$new_size"
  fi

  mkdir "$new_size"
  ln -s "$new_size" "$new_size"@2x

  dir_clone actions
  dir_clone animations
  dir_clone apps
  dir_clone categories
  dir_clone devices
  dir_clone emblems
  dir_clone mimetypes
  dir_clone places
  dir_clone status
}

dir_clone() {
  dirname=$1
  cd $dirname

  if [ -e $new_size ]; then
    rm -rf $new_size
  fi

  mkdir $new_size
  cd $old_size

  for f in $(find -iname "*.png")
  do
    png_size_clone $f
  done

  cd ../../
  cd "$new_size"
  ln -s ../$dirname/$new_size $dirname
  cd ../
}

png_size_clone () {
  f=$1
  echo "Copy png file $new_size: $f"
  filename="${f##*/}"

  if [ -f $f ] && [ -L $f ]; then
    cp -d $f ../$new_size/${filename}
  elif [ -f $f ] && [ ! -L $f ]; then
    convert $f -scale "$new_size"! ../$new_size/${filename}
  fi
}

main
