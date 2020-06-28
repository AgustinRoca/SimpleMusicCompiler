#ifndef PC_2020A_6_TPE_SOCKSV5_SORTED_HASHMAP_H
#define PC_2020A_6_TPE_SOCKSV5_SORTED_HASHMAP_H

#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>

#define GENERIC_INITIAL_HASH_VALUE 5381u
#define GENERIC_SHIFT_HASH_VALUE 5u

typedef struct hashmapCDT *sorted_hashmap_t;
typedef struct hashmap_nodeCDT *sorted_hashmap_node;
typedef struct hashmap_list_CDT *sorted_hashmap_list_t;
typedef struct hashmap_list_node_CDT *sorted_hashmap_list_node_t;
typedef uint64_t hash_t;

/**
 * Crea un hashmap
 * @param initial_overflow_length el valor inicial del tamano del array principal (accessible por hashing)
 * @param element
 * @return el nodo creado | NULL
 */
sorted_hashmap_t sorted_hashmap_create();

/**
 * Busca un elemento
 * @param hashmap
 * @param key
 * @return el nodo creado | NULL
 */
sorted_hashmap_node sorted_hashmap_find(sorted_hashmap_t hashmap, void *key);

/**
 * Agrega un nodo
 * @param hashmap
 * @param key
 * @return node
 */
sorted_hashmap_node sorted_hashmap_add(sorted_hashmap_t hashmap, void *key, const void *value);

/**
 * Obtiene el elemento asociado a un nodo
 * @param node
 * @return value
 */
void *sorted_hashmap_get_element(sorted_hashmap_node node);

/**
 * Remueve un nodo
 * @param hashmap
 * @param node
 */
void sorted_hashmap_remove(sorted_hashmap_t hashmap, sorted_hashmap_node node);

/**
 * Elimina un hashmap
 * @param hashmap
 * @return el nodo creado | NULL
 */
void sorted_hashmap_free(sorted_hashmap_t hashmap);

/**
 * @param hashmap
 * @return cantidad de nodos
 */
uint64_t sorted_hashmap_get_total_nodes(sorted_hashmap_t hashmap);

/**
 * Setea la funcion de comparacion
 * @param hashmap
 * @param cmp la funcion de comparacion (sigue estandar C)
 * @return false si el hashmap ya tenia una funcion de comparacion seteada.
 */
bool sorted_hashmap_set_cmp(sorted_hashmap_t hashmap, int8_t (cmp)(void *key1, void *key2));

/**
 * Setea la funcion de hasheo
 * @param hashmap
 * @param hasher la funcion de hasheo
 * @return false si el hashmap ya tenia una funcion de hasheo seteada.
 */
bool sorted_hashmap_set_hasher(sorted_hashmap_t hashmap, hash_t (hasher)(void *key));

/**
 * Setea la funcion de free. Se encarga de eliminar el elemento de memoria (si es necesario)
 * No es obligatorio. Si no se pasa, no se hace ningun free sobre el elemento
 * Se llama cuando el elemento es removido del mapa
 * @param hashmap
 * @param freer
 * @return
 */
bool sorted_hashmap_set_freer(sorted_hashmap_t hashmap, void (freer)(void *key, void *value));

#endif //PC_2020A_6_TPE_SOCKSV5_SORTED_HASHMAP_H
