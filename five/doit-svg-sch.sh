docker volume rm -f dpVol_sch
docker create --name for_adding_to_volume --mount source=dpVol_sch,target=/circuits ubuntu
docker cp cmosedu_models.txt for_adding_to_volume:/circuits
docker cp five_transistor_ota_sch.cir for_adding_to_volume:/circuits
docker cp p-svg-sch.gp for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=dpVol_sch,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce five_transistor_ota_sch.cir | tee LOG"

docker run --rm --mount source=dpVol_sch,target=/circuits stevenmburns/gnuplot_image bash -c "gnuplot circuits/p-svg-sch.gp"

rm -rf circuits
rm -rf circuits-sch
docker cp xyce_container:/circuits .
docker rm xyce_container
mv circuits circuits-sch

docker run -p 8003:8000 -d --rm --mount source=dpVol_sch,target=/circuits stevenmburns/with_python bash -c "source /sympy/bin/activate && cd circuits && python -m http.server"


