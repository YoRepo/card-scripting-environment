--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Chimera the Flying Mythical Beast  (ID: 4796100)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Beast
-- Level: 6
-- ATK 2100 | DEF 1800
-- Setcode: 0x1b
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Gazelle the King of Mythical Beasts" + "Berfomet"
-- (This card is always treated as a "Phantom Beast" card.)
-- When this card is destroyed: You can target 1 "Berfomet" or 1 "Gazelle the King of Mythical Beasts"
-- in your GY; Special Summon that target.
--[[ __CARD_HEADER_END__ ]]

--有翼幻獣キマイラ
function c4796100.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,5818798,77207191,true,true)
	--Special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4796100,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetTarget(c4796100.sptg)
	e1:SetOperation(c4796100.spop)
	c:RegisterEffect(e1)
end
function c4796100.spfilter(c,e,tp)
	return c:IsCode(5818798,77207191) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c4796100.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c4796100.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c4796100.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c4796100.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c4796100.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
