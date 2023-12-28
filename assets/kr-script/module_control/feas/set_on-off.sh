if [[ ${state} -eq 0 ]]; then
  sed -i 's/\($ Performance governor = \).*/\1false/' $feas_path/feas.conf
else
  sed -i 's/\($ Performance governor = \).*/\1true/' $feas_path/feas.conf
fi