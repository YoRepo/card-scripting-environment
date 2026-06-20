--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 阿基多  (ID: 16135253)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 1300
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，掷1次骰子。可以从自己的墓地中特殊召唤1只等级与掷出点数相同的天使族怪兽上场。（若掷出6，则包括6星以上的怪兽）。
--[[ __CARD_HEADER_END__ ]]

--アギド
function c16135253.initial_effect(c)
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16135253,0))
	e1:SetCategory(CATEGORY_DICE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c16135253.condition)
	e1:SetTarget(c16135253.target)
	e1:SetOperation(c16135253.operation)
	c:RegisterEffect(e1)
end
function c16135253.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c16135253.filter(c,e,tp,lv)
	if (lv~=6 and not c:IsLevel(lv) and c:IsLevelAbove(1)) or (lv==6 and c:IsLevelBelow(5)) then return false end
	return c:IsRace(RACE_FAIRY) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c16135253.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c16135253.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local dc=Duel.TossDice(tp,1)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c16135253.filter),tp,LOCATION_GRAVE,0,nil,e,tp,dc)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(16135253,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
