
import subprocess
import sys

sys.path.append("/home/bennettjames/projects/FrameworkBenchmarks/toolset/setup/linux/")


import re
import os
from os.path import expanduser
import psutil


home = expanduser("~")


def start(args, logfile, errfile):
  try:
    subprocess.check_call("rvm ruby-2.0.0 do bundle install --gemfile=Gemfile-ruby", shell=True, cwd="rails", stderr=errfile, stdout=logfile)
    subprocess.check_call("cp Gemfile-ruby Gemfile", shell=True, cwd="rails", stderr=errfile, stdout=logfile)
    print "should have a gemfile now"
    subprocess.check_call("cp Gemfile-ruby.lock Gemfile.lock", shell=True, cwd="rails", stderr=errfile, stdout=logfile)
    subprocess.check_call("cp config/database-ruby.yml config/database.yml", shell=True, cwd="rails", stderr=errfile, stdout=logfile)
    subprocess.check_call("sudo /usr/sbin/nginx -c " + home + "/projects/FrameworkBenchmarks/rails/config/nginx.conf", shell=True, stderr=errfile, stdout=logfile)
    subprocess.Popen("rvm ruby-2.0.0 do bundle exec unicorn_rails -E production -c config/unicorn.rb", shell=True, cwd="rails", stderr=errfile, stdout=logfile)
    return 0
  except subprocess.CalledProcessError:
    return 1
def stop(logfile, errfile):
  subprocess.call("sudo /usr/sbin/nginx -s stop", shell=True, stderr=errfile, stdout=logfile)
  try:
    p = subprocess.Popen(['ps', 'aux'], stdout=subprocess.PIPE)
    out, err = p.communicate()
    for line in out.splitlines():
      if 'unicorn' in line and 'master' in line:
        pid = int(line.split(None, 2)[1])
        os.kill(pid, 15)
    # subprocess.check_call("rvm ruby-2.0.0-p0 do bundle exec passenger stop --pid-file=$HOME/FrameworkBenchmarks/rack/rack.pid", shell=True, cwd='rack')
    subprocess.check_call("rm Gemfile", shell=True, cwd="rails")
    subprocess.check_call("rm Gemfile.lock", shell=True, cwd="rails")
    return 0
  except subprocess.CalledProcessError:
    return 1






if __name__ == '__main__':

  os.chdir("..")

  # should have an argument here that lets you kill the process
  if "--end" in sys.argv:
    stop(sys.stdout, sys.stderr)
    exit(0)


  from collections import namedtuple


  args = namedtuple('args', 'database_host')

  def memlog(message):
    with open('rails/mem_log', 'w') as f:
      f.write(message)


  def megas(num):
    return str(num / 1024 / 1024) + "MB"

  max_mem = psutil.virtual_memory().total
  start_mem = max_mem - psutil.virtual_memory().available

  print start(args("localhost"), sys.stdout, sys.stderr)

  after_start_mem = max_mem - psutil.virtual_memory().available

  memlog("startup took " + megas(after_start_mem - start_mem) + " of memory\n")


  # Need to do some more advanced diagnostics here. Will need to keep the 
  # process alive for monitoring. Might try to shunt the tests in here, but that
  # might be going past the line. It would be nice to get a simple testing mechanism
  # to work, as I believe that you can trim down the nginx threads (also, there are a 
  # few other small performance things you can play with)

  



