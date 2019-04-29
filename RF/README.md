# RF Example

## Containers to run Xyce, Gnuplot in terminal

```bash
docker volume rm -f rfVol
docker create --name for_adding_to_volume --mount source=rfVol,target=/circuits ubuntu
docker cp cmosedu_models.txt for_adding_to_volume:/circuits
docker cp RF.cir for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=rfVol,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce RF.cir | tee LOG"
docker cp xyce_container:/circuits .
docker rm xyce_container

gnuplot --persist p.gp
```

## Containers to run Xyce and Gnuplot. See result in browser

```bash
docker volume rm -f rfVol
docker create --name for_adding_to_volume --mount source=rfVol,target=/circuits ubuntu
docker cp cmosedu_models.txt for_adding_to_volume:/circuits
docker cp RF.cir for_adding_to_volume:/circuits
docker cp p-svg.gp for_adding_to_volume:/circuits
docker stop for_adding_to_volume
docker rm for_adding_to_volume
docker run --name xyce_container --mount source=rfVol,target=/circuits stevenmburns/xyce_small_ubuntu bash -c "cd circuits && Xyce RF.cir | tee LOG"

docker run --rm --mount source=rfVol,target=/circuits stevenmburns/gnuplot_image bash -c "gnuplot circuits/p-svg.gp"

docker cp xyce_container:/circuits .
docker rm xyce_container

docker run -p 8001:8000 -d --rm --mount source=rfVol,target=/circuits stevenmburns/with_python bash -c "source /sympy/bin/activate && cd circuits && python -m http.server"
```
Then view the svg file by pointing to `localhost:8001/RF.svg`.