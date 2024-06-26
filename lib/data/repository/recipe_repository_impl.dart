import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/constants.dart';
import 'package:recipe_app/utils/data_state.dart';
import 'package:recipe_app/data/local/recipe_entity.dart';
import 'package:recipe_app/data/remote/recipe_api_service.dart';
import '../../domain/model/recipe.dart';
import '../../domain/repository/recipe_repository.dart';
import '../local/database_service.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeApiService recipeService;
  final DatabaseService databaseService;

  static const appId = 'e2d185a1';
  static const appKey = 'cf6eb12d22058c773fc8fcd3aad2e306';

  RecipeRepositoryImpl(
      {required this.recipeService, required this.databaseService});

  @override
  Future<DataState<List<Recipe>>> getRecipes({
    required String query,
    required String mealType,
    required String dishType,
    required String cuisineType,
    required String diet,
    required String calories,
    required String totalTime,
  }) async {
    try {
      var httpResponse = await recipeService.getRecipes(
          appKey: appKey,
          appId: appId,
          query: query.isEmpty ? null : query,
          queryParams: getQueryParameters(
              mealType: mealType,
              dishType: dishType,
              cuisineType: cuisineType,
              diet: diet,
              calories: calories,
              totalTime: totalTime));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final hits = httpResponse.data.hits;
        return DataSuccess(
            hits!
                .map((apiHits) => Recipe.fromRecipeDto(apiHits.recipeDto))
                .toList(),
            httpResponse.data.links?.next?.nextPage);
      } else {
        logger.log(Logger.level, "fetch failed");
        return DataFailed(DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            error: httpResponse.response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Map<String, dynamic> getQueryParameters({
    required String mealType,
    required String dishType,
    required String cuisineType,
    required String diet,
    required String calories,
    required String totalTime,
  }) {
    Map<String, dynamic> queryParameters = {};
    if (calories.isNotEmpty) {
      queryParameters[CALORIES] = calories;
    }
    if (diet.isNotEmpty) {
      List<String> dietList = diet.split(',');
      var lowercaseList =
          dietList.map((element) => element.toLowerCase()).toList();
      queryParameters[DIET_TYPE] = lowercaseList;
    }
    if (mealType.isNotEmpty) {
      queryParameters[MEAL_TYPE] = mealType;
    }
    if (dishType.isNotEmpty) {
      queryParameters[DISH_TYPE] = dishType;
    }
    if (totalTime.isNotEmpty) {
      queryParameters[TOTAL_TIME] = totalTime;
    }
    if (cuisineType != 'All') {
      queryParameters[CUISINE_TYPE] = cuisineType;
    }

    return queryParameters;
  }

  @override
  Future<DataState<List<Recipe>>> getNextPageRecipes(
      {required String? nextPageUrl}) async {
    try {
      var httpResponse =
          await recipeService.getNextPageRecipes(nextPageUrl: nextPageUrl);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final hits = httpResponse.data.hits;
        return DataSuccess(
            hits!
                .map((apiHits) => Recipe.fromRecipeDto(apiHits.recipeDto))
                .toList(),
            httpResponse.data.links?.next?.nextPage);
      } else {
        return DataFailed(DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            error: httpResponse.response.statusMessage));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
