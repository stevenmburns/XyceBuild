docker volume rm -f rfVol
docker create --name for_adding_to_volume --mount source=rfVol,target=/circuits ubuntu
docker cp cmosedu_models.txt for_adding_to_volume:/circuits
docker cp RF.cir for_adding_to_volume:/circuits
docker cp p-png.gp for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=rfVol,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce RF.cir | tee LOG"

docker run --rm --mount source=rfVol,target=/circuits gnuplot_image bash -c "gnuplot circuits/p-svg.gp"

docker cp xyce_container:/circuits .
docker rm xyce_container

docker run -p 8001:8000 -d --rm --mount source=rfVol,target=/circuits with_python bash -c "source /general/bin/activate && cd circuits && python -m http.server &"


