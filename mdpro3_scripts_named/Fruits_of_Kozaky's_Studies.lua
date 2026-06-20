--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 平庸鬼的研究成果  (ID: 49998907)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己卡组最上面3张卡确认，并且把那些卡按照自己的意愿交换顺序放回卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--コザッキーの研究成果
function c49998907.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c49998907.target)
	e1:SetOperation(c49998907.activate)
	c:RegisterEffect(e1)
end
function c49998907.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c49998907.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,3)
end
