import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AmplifyData {
  // create
  Future<T?> createModel<T extends Model>(T modelInstance) async { 
    try {
      final request = ModelMutations.create(modelInstance);
      final response = await Amplify.API.mutate(request: request).response;
      
      if(response.hasErrors) {
        return null;
      }

      return response.data;
    } on ApiException catch (e) {
      safePrint('API Exception during mutation: $e');
      return null; // Return null in case of an API exception
    } catch (e) {
      safePrint('Unexpected error: $e');
      return null; // Return null in case of any other exception
    }
  }
  // create unauthenticated
  Future<T?> createModelPublic<T extends Model>(T modelInstance) async {
    try {
      final request = ModelMutations.create(
        modelInstance,
        authorizationMode: APIAuthorizationType.iam,
      );
      final response = await Amplify.API.mutate(request: request).response;
      
      if(response.hasErrors) {
        return null;
      }

      return response.data;
    } on ApiException catch (e) {
      throw Exception('API Exception during mutation: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // UPDATE DATA
  Future<T?> updateModel<T extends Model>(T updatedModel) async {
    try {
      final request = ModelMutations.update(updatedModel);
      final response = await Amplify.API.mutate(request: request).response;

      if (response.hasErrors) {
        throw Exception('Error updating model: ${response.errors}');
      }

      return response.data;
    } on ApiException catch (e) {
      throw Exception('Error updating model: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // DELETE MODEL
  Future<bool> deleteModel<T extends Model>({
    required T modelToDelete,
  }) async {
    try {
      final request = ModelMutations.delete(modelToDelete);
      final response = await Amplify.API.mutate(request: request).response;

      if (response.hasErrors) {
        throw Exception('Error deleting model: ${response.errors}');
      }

      return response.data != null; // Return true if deletion was successful
    } on ApiException catch (e) {
      throw Exception('Error deleting model: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // DELETE MODEL BY ID
  Future<bool> deleteModelById<T extends Model>({
    required ModelType<T> modelType,
    required ModelIdentifier<T> modelIdentifier,
  }) async {
    try {
      final request = ModelMutations.deleteById(
        modelType,
        modelIdentifier,
      );
      final response = await Amplify.API.mutate(request: request).response;

      if (response.hasErrors) {
        throw Exception('Error deleting model by ID: ${response.errors}');
      }

      return response.data != null; // Return true if deletion was successful
    } on ApiException catch (e) {
      throw Exception('Error deleting model by ID: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // QUERY MODEL BY ID
  Future<T?> queryItems<T extends Model>({
    required ModelType<T> modelType,
    required ModelIdentifier<T> modelIdentifier,
  }) async {
    try {
      final request = ModelQueries.get(
        modelType,
        modelIdentifier,
      );
      final response = await Amplify.API.query(request: request).response;
      if (response.hasErrors) {
        throw Exception('errors: ${response.errors}');
      }
      return response.data;
    } on ApiException catch (e) {
      throw Exception('Query failed: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

    // QUERY MODEL BY ID
  Future<T?> queryItemsPublic<T extends Model>({
    required ModelType<T> modelType,
    required ModelIdentifier<T> modelIdentifier,
  }) async {
    try {
      final request = ModelQueries.get(
        modelType,
        modelIdentifier,
        authorizationMode: APIAuthorizationType.iam
      );
      final response = await Amplify.API.query(request: request).response;
      if (response.hasErrors) {
        throw Exception('errors: ${response.errors}');
      }
      return response.data;
    } on ApiException catch (e) {
      throw Exception('Query failed: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // QUERY LIST OF MODEL
  Future<List<Model?>> queryListItems<T extends Model>(ModelType<T> modelType, QueryPredicate<Model>? where) async {
    try {
      final request = ModelQueries.list(modelType, where: where);
      final response = await Amplify.API.query(request: request).response;

      final dataList = response.data?.items;
      if (dataList == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      return dataList;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }
  
  Future<List<Model?>> queryPaginatedListItems<T extends Model>({
    required ModelType<T> modelType, 
    required int limit
  }) async {
    final firstRequest = ModelQueries.list(modelType, limit: limit);
    final firstResult = await Amplify.API.query(request: firstRequest).response;
    final firstPageData = firstResult.data;
    
    if (firstPageData?.hasNextResult ?? false) {
      final secondRequest = firstPageData!.requestForNextResult;
      final secondResult = await Amplify.API.query(request: secondRequest!).response;
      return secondResult.data?.items ?? <T?>[];
    } else {
      return firstPageData?.items ?? <T?>[];
    }
  }
  // stream
  Stream<GraphQLResponse<T>> subscribe<T extends Model>({
    required ModelType<T> modelType,
    required SubscriptionType type
  }) {
    GraphQLRequest<T> subscriptionRequest;

    // Choose the appropriate subscription request based on the type
    switch (type) {
      case SubscriptionType.onCreate:
        subscriptionRequest = ModelSubscriptions.onCreate(modelType);
        break;
      case SubscriptionType.onUpdate:
        subscriptionRequest = ModelSubscriptions.onUpdate(modelType);
        break;
      case SubscriptionType.onDelete:
        subscriptionRequest = ModelSubscriptions.onDelete(modelType);
        break;
    }

    final Stream<GraphQLResponse<T>> operation = Amplify.API
    .subscribe(subscriptionRequest, onEstablished: () => safePrint('subscription established'))
    .handleError((Object error) => safePrint('Error in subscription stream: $error'));

    return operation;
  }
  // stream unathenticated
  Stream<GraphQLResponse<T>> subscribePublic<T extends Model>({
    required ModelType<T> modelType,
    required SubscriptionType type
  }) {
    GraphQLRequest<T> subscriptionRequest;

    // Choose the appropriate subscription request based on the type
    switch (type) {
      case SubscriptionType.onCreate:
        subscriptionRequest = ModelSubscriptions.onCreate(
          modelType,
          authorizationMode: APIAuthorizationType.iam,
        );
        break;
      case SubscriptionType.onUpdate:
        subscriptionRequest = ModelSubscriptions.onUpdate(
          modelType,
          authorizationMode: APIAuthorizationType.iam,
        );
        break;
      case SubscriptionType.onDelete:
        subscriptionRequest = ModelSubscriptions.onDelete(
          modelType,
          authorizationMode: APIAuthorizationType.iam,
        );
        break;
    }

    final Stream<GraphQLResponse<T>> operation = Amplify.API
    .subscribe(subscriptionRequest, onEstablished: () => safePrint('subscription established'))
    .handleError(
      (Object error) => safePrint('Error in subscription stream: $error'),
    );

    return operation;
  }
}

enum SubscriptionType { onCreate, onUpdate, onDelete }