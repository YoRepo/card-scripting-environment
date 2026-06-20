--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 红莲之炎壁  (ID: 47658964)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己墓地存在的名字带有「熔岩」的怪兽任意数量从游戏中除外发动。为这张卡发动而除外的怪兽数量的「熔岩衍生物」（炎族·炎·1星·攻/守0）在自己场上守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--紅蓮の炎壁
function c47658964.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c47658964.cost)
	e1:SetTarget(c47658964.target)
	e1:SetOperation(c47658964.activate)
	c:RegisterEffect(e1)
end
function c47658964.cfilter(c)
	return c:IsSetCard(0x39) and c:IsAbleToRemoveAsCost()
end
function c47658964.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c47658964.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c47658964.cfilter,tp,LOCATION_GRAVE,0,1,ft,nil)
	e:SetLabel(g:GetCount())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c47658964.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,47658965,0x39,TYPES_TOKEN_MONSTER,0,0,1,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,e:GetLabel(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,e:GetLabel(),0,0)
end
function c47658964.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<e:GetLabel() or not Duel.IsPlayerCanSpecialSummonMonster(tp,47658965,0x39,TYPES_TOKEN_MONSTER,0,0,1,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP_DEFENSE)
		or (e:GetLabel()>1 and Duel.IsPlayerAffectedByEffect(tp,59822133)) then return end
	for i=1,e:GetLabel() do
		local token=Duel.CreateToken(tp,47658965)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
	Duel.SpecialSummonComplete()
end
