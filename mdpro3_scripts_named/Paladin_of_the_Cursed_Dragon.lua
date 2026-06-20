--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 暗龙之黑骑士  (ID: 68670547)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Zombie
-- Level 4
-- ATK 1900 | DEF 1200
--
-- Effect Text:
-- ①：1回合1次，以被战斗破坏的对方墓地1只4星以下的不死族怪兽为对象才能发动。那只不死族怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--闇竜の黒騎士
function c68670547.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68670547,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c68670547.sptg)
	e1:SetOperation(c68670547.spop)
	c:RegisterEffect(e1)
end
function c68670547.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_ZOMBIE)
		and c:IsReason(REASON_BATTLE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68670547.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c68670547.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c68670547.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c68670547.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c68670547.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_ZOMBIE) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
