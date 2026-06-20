--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 阳炎兽 蝎狮  (ID: 96051150)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Winged Beast
-- Level 6
-- ATK 2200 | DEF 300
-- Setcode: 4221
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方不能把这张卡作为卡的效果的对象。此外，1回合1次，把手卡或者自己场上表侧表示存在的1只炎属性怪兽送去墓地才能发动。这个回合，这张卡不会被卡的效果破坏。这个效果在对方回
-- 合也能发动。
--[[ __CARD_HEADER_END__ ]]

--陽炎獣 メコレオス
function c96051150.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96051150,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c96051150.cost)
	e2:SetOperation(c96051150.operation)
	c:RegisterEffect(e2)
end
function c96051150.cfilter(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToGraveAsCost()
end
function c96051150.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96051150.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c96051150.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c96051150.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
