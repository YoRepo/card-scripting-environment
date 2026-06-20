--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 幻魔的殉教者  (ID: 93224848)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：这张卡以外的自己手卡有2张以上存在，自己场上有「神炎皇 乌利亚」或者「降雷皇 哈蒙」存在的场合，把手卡全部送去墓地才能发动。在自己场上把3只「幻魔的殉教者衍生物」（恶魔族·暗·1星·攻/守0）攻击
-- 表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--幻魔の殉教者
function c93224848.initial_effect(c)
	aux.AddCodeList(c,6007213,32491822)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c93224848.condition)
	e1:SetCost(c93224848.cost)
	e1:SetTarget(c93224848.target)
	e1:SetOperation(c93224848.activate)
	c:RegisterEffect(e1)
end
function c93224848.filter(c)
	return c:IsFaceup() and c:IsCode(6007213,32491822)
end
function c93224848.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,2,e:GetHandler())
		and Duel.IsExistingMatchingCard(c93224848.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c93224848.cfilter(c)
	return not c:IsAbleToGraveAsCost()
end
function c93224848.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsExistingMatchingCard(c93224848.cfilter,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST)
end
function c93224848.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsPlayerCanSpecialSummonMonster(tp,93224849,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c93224848.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsPlayerCanSpecialSummonMonster(tp,93224849,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP_ATTACK) then
		for i=1,3 do
			local token=Duel.CreateToken(tp,93224849)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
		Duel.SpecialSummonComplete()
	end
end
