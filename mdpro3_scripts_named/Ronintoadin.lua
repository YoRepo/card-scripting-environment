--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 粹蛙  (ID: 1357146)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 2
-- ATK 100 | DEF 2000
--
-- Effect Text:
-- 这张卡不能作为同调素材。
-- ①：这张卡只要在怪兽区域存在，卡名当作「死亡青蛙」使用。
-- ②：这张卡在墓地存在的场合，从自己墓地把1只「青蛙」怪兽除外才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--粋カエル
function c1357146.initial_effect(c)
	--change code
	aux.EnableChangeCode(c,84451804)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1357146,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c1357146.cost)
	e2:SetTarget(c1357146.target)
	e2:SetOperation(c1357146.operation)
	c:RegisterEffect(e2)
	--synchro limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c1357146.costfilter(c)
	return c:IsSetCard(0x12) and c:IsAbleToRemoveAsCost()
end
function c1357146.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1357146.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c1357146.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c1357146.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c1357146.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
