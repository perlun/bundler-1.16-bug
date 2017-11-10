map '/hello' do
  run ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['Hello World!']] }
end

map '/reload' do
  run ->(_env) {
    Process.kill('USR2', Process.pid)
    [200, { 'Content-Type' => 'text/plain' }, ['Reloading.']]
  }
end
