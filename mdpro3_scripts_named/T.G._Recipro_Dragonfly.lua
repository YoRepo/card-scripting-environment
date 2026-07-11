--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: T.G. Recipro Dragonfly  (ID: 62560742)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Insect
-- Level: 2
-- ATK 300 | DEF 300
-- Setcode: 0x27
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1 non-Tuner monster
-- Once per turn: You can target 1 other "T.G." Synchro Monster you control; send it to the GY, then,
-- if all the Synchro Monsters that were used for its Synchro Summon are in your GY, you can Special
-- Summon all of them.
--[[ __CARD_HEADER_END__ ]]

--TG レシプロ・ドラゴン・フライ
function c62560742.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1,1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62560742,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c62560742.target)
	e1:SetOperation(c62560742.operation)
	c:RegisterEffect(e1)
end
function c62560742.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x27) and c:IsType(TYPE_SYNCHRO)
end
function c62560742.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c62560742.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c62560742.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(62560742,2))
	local g=Duel.SelectTarget(tp,c62560742.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c62560742.mgfilter(c,e,tp,sync)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_SYNCHRO)
		and bit.band(c:GetReason(),0x80008)==0x80008 and c:GetReasonCard()==sync
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c62560742.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetMaterial()
	local ct=mg:GetCount()
	local sumtype=tc:GetSummonType()
	if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and sumtype==SUMMON_TYPE_SYNCHRO
		and ct>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and ct<=Duel.GetLocationCount(tp,LOCATION_MZONE)
		and mg:FilterCount(aux.NecroValleyFilter(c62560742.mgfilter),nil,e,tp,tc)==ct
		and Duel.SelectYesNo(tp,aux.Stringid(62560742,1)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end
