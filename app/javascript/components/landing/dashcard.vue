<template>
    <div class="col col-sm-12 col-lg-6 my-3">
        <div class="card" :class="data.color">
            <div class="card-body">
            <p class="card-title h2">{{data.count}}</p>
            <p class="card-text">{{data.name}}</p>
            </div>
            <div class="card-footer text-muted text-center">
                <a :href="data.url" class="btn btn-outline w-50">Show more</a>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: ['data'],
}
</script>