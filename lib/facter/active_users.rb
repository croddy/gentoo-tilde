Facter.add(:active_users) do
  setcode 'who | cut -d\  -f1|sort|uniq|sed -e \':a;N;$!ba;s/\n/ /g\''
end
