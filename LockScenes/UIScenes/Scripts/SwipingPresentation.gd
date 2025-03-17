extends ScrollContainer

class_name SwipingPresentation

@export var slides : Array[MarginContainer]
@export var swipeTime : float = 1.5
@export var slideDistance : float = 600
@export var customMax : int
var scrollStep : float
var currentSlide : int = 0
var numSlides : int
var currentTween : Tween
var moving : bool = false
var maxScroll : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PrepSlideDeck()
	get_v_scroll_bar().set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		SlideUp()
		await get_tree().create_timer(swipeTime * 1.1).timeout
	
	if Input.is_action_just_pressed("ui_down"):
		SlideDown()
		await get_tree().create_timer(swipeTime * 1.1).timeout
	
	# print(get_v_scroll_bar().value)

func PrepSlideDeck():
	numSlides = slides.size()
	scrollStep = 1.0 / numSlides
	maxScroll = customMax
	print(numSlides, " : ", scrollStep, " : ", maxScroll)
	get_v_scroll_bar().value = 0


func SlideUp():
	if !moving && 0 < currentSlide:
		moving = true
		print("Going up")
		currentTween = TweenPosition(self, currentTween,  maxScroll * scrollStep * (currentSlide - 1), swipeTime)
		print(get_v_scroll_bar().value, " : ", maxScroll * scrollStep * (currentSlide - 1))
		currentSlide -= 1
		await currentTween.finished
		moving = false


func SlideDown():
	if !moving && numSlides - 1 > currentSlide:
		moving = true
		print("Going down")
		currentTween = TweenPosition(self, currentTween, (maxScroll * scrollStep * (currentSlide + 1)), swipeTime)
		print(get_v_scroll_bar().value, " : ", maxScroll * scrollStep * (currentSlide + 1))
		currentSlide += 1
		await currentTween.finished
		moving = false


func TweenPosition(whatObject, whichTween, desiredPosition, desiredLength):
	whichTween = create_tween().bind_node(whatObject.get_v_scroll_bar())
	whichTween.set_trans(Tween.TRANS_SINE)
	whichTween.set_ease(Tween.EASE_IN_OUT)
	whichTween.tween_property(whatObject.get_v_scroll_bar(), "value", desiredPosition, desiredLength)
	print("	Should be tweening scroll bar")
	return whichTween
