# row_and_column

1. 공부한 내용
- 컨테이너가 상단바를 벗어난 상태. ![img.png](study1_outrangeTopBar.png)
- 현재 커밋까지 벗어난 상황을 저장. 이후에 해결하고 방지하는 법 공부
- 1차 해결. Scaffold - SafeArea를 설정하여 상단쪽은 해결. 
- ![img.png](img.png)
- 그러나, 하단바는 괜찮아 보이기에 그냥 넘어가도 괜찮다고 판단 후 하단만 허용하기로 결정. 
- ![img_1.png](img_1.png)
- 안드로이드는 큰 변화가 없지만, 아이폰에서는 아래까지 꽉 차는 것을 확인가능.
- SafeArea({ bottom : false });를 사용함.