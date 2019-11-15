docker volume rm -f dpVol
docker create --name for_adding_to_volume --mount source=dpVol,target=/circuits ubuntu
docker cp cmosedu_models.txt for_adding_to_volume:/circuits
docker cp five.cir for_adding_to_volume:/circuits
docker cp p-svg.gp for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=dpVol,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce five.cir | tee LOG"

docker cp xyce_container:/circuits .
docker rm xyce_container



