docker volume rm -f dpVol_polo
docker create --name for_adding_to_volume --mount source=dpVol_polo,target=/circuits ubuntu
docker cp cmosedu_models.txt for_adding_to_volume:/circuits
docker cp five_transistor_ota.cir for_adding_to_volume:/circuits
docker cp p-svg-polo.gp for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=dpVol_polo,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce five_transistor_ota.cir | tee LOG"

docker run --rm --mount source=dpVol_polo,target=/circuits stevenmburns/gnuplot_image bash -c "gnuplot circuits/p-svg-polo.gp"

rm -rf circuits
rm -rf circuits-polo
docker cp xyce_container:/circuits .
docker rm xyce_container
mv circuits circuits-polo

docker run -p 8002:8000 -d --rm --mount source=dpVol_polo,target=/circuits stevenmburns/with_python bash -c "source /sympy/bin/activate && cd circuits && python -m http.server"


