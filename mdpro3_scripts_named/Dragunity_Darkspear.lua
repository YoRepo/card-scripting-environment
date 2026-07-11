--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Dragunity Darkspear  (ID: 13361027)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level: 3
-- ATK 1000 | DEF 1000
-- Setcode: 0x29
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can Tribute 1 Dragon "Dragunity" monster, then target 1 Level 4 or lower Winged
-- Beast monster in your GY; Special Summon that target.
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－ブラックスピア
function c13361027.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13361027,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c13361027.cost)
	e1:SetTarget(c13361027.target)
	e1:SetOperation(c13361027.operation)
	c:RegisterEffect(e1)
end
function c13361027.cfilter(c,tp)
	return c:IsSetCard(0x29) and c:IsRace(RACE_DRAGON)
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c13361027.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c13361027.cfilter,1,nil,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c13361027.cfilter,1,1,nil,tp)
	Duel.Release(rg,REASON_COST)
end
function c13361027.filter(c,e,sp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_WINDBEAST) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c13361027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c13361027.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c13361027.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c13361027.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13361027.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_WINDBEAST) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
