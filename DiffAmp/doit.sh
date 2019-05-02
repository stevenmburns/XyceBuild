docker volume rm -f rfVol
docker create --name for_adding_to_volume --mount source=rfVol,target=/circuits ubuntu
docker cp ../cmosedu_models.txt for_adding_to_volume:/circuits
docker cp DiffAmp.cir for_adding_to_volume:/circuits
docker cp p.gp for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=rfVol,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce DiffAmp.cir | tee LOG"
docker run --rm --mount source=rfVol,target=/circuits stevenmburns/gnuplot_image bash -c "gnuplot circuits/p.gp"
docker cp xyce_container:/circuits .
docker rm xyce_container
docker run -p 8001:8000 -d --rm --mount source=rfVol,target=/circuits stevenmburns/with_python bash -c "source /sympy/bin/activate && cd circuits && python -m http.server"
