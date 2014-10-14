Facter.add(:active_users) do
  setcode do
    exec('( who; last --since -15min )|head -n -2|cut -d\  -f1|sort|uniq|sed -e \':a;N;$!ba;s/\n/ /g\'')
  end
end
