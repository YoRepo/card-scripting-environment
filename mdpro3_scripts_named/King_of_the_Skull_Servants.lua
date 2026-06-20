--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 白骨王  (ID: 36021814)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 1
-- ATK ? | DEF 0
--
-- Effect Text:
-- ①：这张卡的原本攻击力变成自己墓地的「白骨王」「白骨」数量×1000。
-- ②：这张卡被战斗破坏送去墓地时，从自己墓地把1只其他的「白骨王」或「白骨」除外才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ワイトキング
function c36021814.initial_effect(c)
	aux.AddCodeList(c,32274490)
	--base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c36021814.atkval)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36021814,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c36021814.condition)
	e2:SetCost(c36021814.cost)
	e2:SetTarget(c36021814.target)
	e2:SetOperation(c36021814.operation)
	c:RegisterEffect(e2)
end
function c36021814.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,32274490,36021814)*1000
end
function c36021814.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
		and bit.band(e:GetHandler():GetReason(),REASON_BATTLE)~=0
end
function c36021814.costfilter(c)
	return c:IsCode(32274490,36021814) and c:IsAbleToRemoveAsCost()
end
function c36021814.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c36021814.costfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c36021814.costfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c36021814.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c36021814.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
