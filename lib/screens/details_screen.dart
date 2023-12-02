import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/controllers/movies_controller.dart';

import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/actorMovie.dart';
import 'package:movies_app/models/actorTv.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.actor,
  }) : super(key: key);

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    ApiService.getActors();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back to home',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Know more about the actor',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    Tooltip(
                      message: 'Save this actor with your favourite ones',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<ActorsController>().addToWatchList(actor);
                        },
                        icon: Obx(
                          () =>
                              Get.find<ActorsController>().isInWatchList(actor)
                                  ? const Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 33,
                                    )
                                  : const Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.white,
                                      size: 33,
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        Api.imageBaseUrl + actor.profilePath,
                        width: Get.width,
                        height: 250,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, __, ___) {
                          if (___ == null) return __;
                          return FadeShimmer(
                            width: Get.width,
                            height: 250,
                            highlightColor: const Color(0xff22272f),
                            baseColor: const Color(0xff20252d),
                          );
                        },
                        errorBuilder: (_, __, ___) => const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            size: 250,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${actor.profilePath}',
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 110,
                                height: 140,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          actor.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/Star.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              actor.popularity == 0.0
                                  ? 'N/A'
                                  : actor.popularity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Opacity(
                opacity: .6,
                child: SizedBox(
                  width: Get.width / 1.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/calender.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            actor.popularity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Text('|'),
                      Row(
                        children: [
                          SvgPicture.asset('assets/Ticket.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "hello",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'Details'),
                            Tab(text: 'Movies'),
                            Tab(text: 'TV'),
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(
                          children: [
                            FutureBuilder<List<Detail>?>(
                              future: ApiService.getDetails(actor.id),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: Text(
                                      'No details',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (_, index) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].name
                                                .toString(),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 252, 252),
                                              fontSize: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Birthday: ${snapshot.data![index].birthday}",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot.data![index].biography,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Popularity: ${snapshot.data![index].popularity}",
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 187, 185, 185),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            FutureBuilder<List<ActorMovie>?>(
                              future: ApiService.getActorMovie(actor.name),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else if (snapshot.hasData) {
                                  List<ActorMovie> cast = snapshot.data!;
                                  return cast.isEmpty
                                      ? const Center(
                                          child: Text(
                                              'No cast information available.'),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            ActorMovie actor =
                                                snapshot.data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                        YourMovieDetailPage(
                                                          movieDetails: actor,
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        actor.getFoto(),
                                                        height: 150,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    actor.title,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    actor.releaseDate,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                } else {
                                  return const Center(
                                    child:
                                        Text('No movie information available.'),
                                  );
                                }
                              },
                            ),
                            FutureBuilder<List<ActorTV>?>(
                              future: ApiService.getActorSerie(actor.name),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else if (snapshot.hasData) {
                                  List<ActorTV> cast = snapshot.data!;
                                  return cast.isEmpty
                                      ? const Center(
                                          child: Text(
                                              'No cast information available.'),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            ActorTV actor =
                                                snapshot.data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                        YourTVDetailPage(
                                                          serieDetails: actor,
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        actor.getFoto(),
                                                        height: 150,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    actor.name,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    actor.firstairdate,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                } else {
                                  return const Center(
                                    child: Text('No tv information available.'),
                                  );
                                }
                              },
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class YourMovieDetailPage extends StatelessWidget {
  final ActorMovie movieDetails;

  const YourMovieDetailPage({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieDetails.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movieDetails.getFoto(),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Title: ${movieDetails.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Release Date: ${movieDetails.releaseDate}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class YourTVDetailPage extends StatelessWidget {
  final ActorTV serieDetails;

  const YourTVDetailPage({super.key, required this.serieDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serieDetails.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              serieDetails.getFoto(),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Title: ${serieDetails.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Release Date: ${serieDetails.firstairdate}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
