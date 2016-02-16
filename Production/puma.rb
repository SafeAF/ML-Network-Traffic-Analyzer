# config/puma.rb
threads 8,32
workers 3
preload_app!

#$ puma -t 8:32 -w 3 --preload