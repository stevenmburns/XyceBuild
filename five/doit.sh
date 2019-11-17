docker volume rm -f dpVol
docker create --name for_adding_to_volume --mount source=dpVol,target=/circuits ubuntu
docker cp cmosedu_models.txt for_adding_to_volume:/circuits
docker cp five.cir for_adding_to_volume:/circuits
docker cp five_transistor_ota.cir for_adding_to_volume:/circuits
docker cp p.gp for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=dpVol,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce five.cir && Xyce five_transistor_ota.cir | tee LOG"

docker run --rm --mount source=dpVol,target=/circuits stevenmburns/gnuplot_image bash -c "gnuplot circuits/p.gp"

docker cp xyce_container:/circuits .
docker rm xyce_container

docker run -p 8001:8000 -d --rm --mount source=dpVol,target=/circuits stevenmburns/with_python bash -c "source /sympy/bin/activate && cd circuits && python -m http.server"


