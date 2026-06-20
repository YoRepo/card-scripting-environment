--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 暗黑沙貘  (ID: 70187958)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 2
-- ATK 1100 | DEF 300
--
-- Effect Text:
-- 这张卡从游戏中除外时，可以选择自己墓地存在的1只4星以下的兽族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダーク砂バク
function c70187958.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70187958,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_REMOVE)
	e1:SetTarget(c70187958.target)
	e1:SetOperation(c70187958.operation)
	c:RegisterEffect(e1)
end
function c70187958.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_BEAST) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c70187958.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c70187958.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c70187958.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c70187958.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c70187958.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
