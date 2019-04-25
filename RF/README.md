# RF Example

```bash
docker build -t rf_image .
```

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