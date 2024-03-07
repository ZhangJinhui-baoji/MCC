if [[ ${state} -eq 0 ]]; then
  sed -i 's/\($ Performance governor = \).*/\1false/' /data/feas.conf
else
  sed -i 's/\($ Performance governor = \).*/\1true/' /data/feas.conf
fi