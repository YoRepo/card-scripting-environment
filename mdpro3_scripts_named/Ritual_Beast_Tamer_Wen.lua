--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ritual Beast Tamer Wen  (ID: 40907115)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level: 3
-- ATK 1500 | DEF 1000
-- Setcode: 0x10b5
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal Summoned: You can target 1 of your banished "Ritual Beast" monsters; Special
-- Summon it.
-- You can only Special Summon "Ritual Beast Tamer Wen(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--霊獣使い ウェン
function c40907115.initial_effect(c)
	c:SetSPSummonOnce(40907115)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40907115,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c40907115.sptg)
	e1:SetOperation(c40907115.spop)
	c:RegisterEffect(e1)
end
function c40907115.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xb5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c40907115.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c40907115.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c40907115.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c40907115.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c40907115.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
