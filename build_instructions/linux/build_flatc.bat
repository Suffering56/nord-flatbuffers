cd ..\..\

docker build -t magic56/cmake_linux -f build_instructions/linux/Dockerfile .

docker run -itd --name cmake_linux magic56/cmake_linux

docker exec --workdir /home/flatbuffers cmake_linux /home/cmake/bin/cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
docker exec --workdir /home/flatbuffers cmake_linux make
docker exec --workdir /home/flatbuffers cmake_linux make install

docker cp cmake_linux:/home/flatbuffers/flatc ./build_instructions/linux/

docker rm -f cmake_linux

docker rmi magic56/cmake_linux

pause