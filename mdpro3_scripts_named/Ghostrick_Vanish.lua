--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 鬼计匿影  (ID: 50527144)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 141
--
-- Effect Text:
-- 把手卡1只名字带有「鬼计」的怪兽给对方观看才能发动。这个回合，自己场上的名字带有「鬼计」的卡以及里侧守备表示存在的怪兽不会成为卡的效果的对象，不会被卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・アウト
function c50527144.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c50527144.cost)
	e1:SetOperation(c50527144.activate)
	c:RegisterEffect(e1)
end
function c50527144.cfilter(c)
	return c:IsSetCard(0x8d) and c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c50527144.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50527144.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c50527144.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c50527144.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(c50527144.tgfilter)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
end
function c50527144.tgfilter(e,c)
	return (c:IsFaceup() and c:IsSetCard(0x8d)) or (c:IsFacedown() and c:IsLocation(LOCATION_MZONE))
end
