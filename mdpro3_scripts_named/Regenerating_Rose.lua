--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 分裂魔界蔷薇  (ID: 31986288)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 7
-- ATK 0 | DEF 1500
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以在自己场上把2只「魔界蔷薇衍生物」（植物族·暗·3星·攻/守1200）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スプリット・D・ローズ
function c31986288.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31986288,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c31986288.condition)
	e1:SetTarget(c31986288.target)
	e1:SetOperation(c31986288.operation)
	c:RegisterEffect(e1)
end
function c31986288.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c31986288.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,31986289,0,TYPES_TOKEN_MONSTER,1200,1200,3,RACE_PLANT,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c31986288.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,31986289,0,TYPES_TOKEN_MONSTER,1200,1200,3,RACE_PLANT,ATTRIBUTE_DARK) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,31986289)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
